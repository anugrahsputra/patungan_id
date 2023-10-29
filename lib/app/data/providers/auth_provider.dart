import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data.dart';

abstract class AuthProvider {
  Future<void> signInWithPhoneNumber(String phoneNumber);
  Future<void> verifyOtp(String otp);
  Future<void> resendOtp(String phoneNumber);
  Future<void> signOut();
  Future<void> saveDataToDatabase(String name);
  Future<String> getCurrentId();
  Future<UserModel> getCurrentUser();
  Stream<UserModel> getUserById(String uid);
  Future<bool> isUserExist(String uid);
  Future<void> setUserLoggedIn(String uid);
  Future<void> removeUser(String uid);
  String? getUser();
}

class AuthProviderImpl implements AuthProvider {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final SharedPreferences sharedPreferences;

  String _verificationId = '';
  int? _resendOtp;

  final Logger log = Logger("Auth Provider");

  AuthProviderImpl(this.auth, this.firestore, this.sharedPreferences);

  @override
  Future<String> getCurrentId() async {
    final currentId = auth.currentUser!.uid;
    log.fine(currentId);
    return currentId;
  }

  @override
  Future<UserModel> getCurrentUser() async {
    var userData =
        await firestore.collection('users').doc(await getCurrentId()).get();
    UserModel user = UserModel.fromMap(userData.data()!);
    return user;
  }

  @override
  Stream<UserModel> getUserById(String uid) {
    return firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!));
  }

  @override
  Future<void> saveDataToDatabase(String name) async {
    String uid = await getCurrentId();
    log.fine(uid);

    String photoUrl = '';
    var user = UserModel(
      id: uid,
      phoneNumber: auth.currentUser!.phoneNumber!,
      name: name,
      profilePic: photoUrl,
      groupId: const [],
      friendsId: const [],
    );

    var userDoc = await firestore.collection('users').doc(uid).get();
    if (userDoc.exists) {
      await firestore.collection('users').doc(uid).update(user.toMap());
    } else {
      await firestore.collection('users').doc(uid).set(user.toMap());
    }
  }

  @override
  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        await auth.signInWithCredential(phoneAuthCredential);
        if (kDebugMode) {
          log.fine('phone verified: Token ${phoneAuthCredential.token}');
        }
      },
      verificationFailed: (error) {
        log.severe(error);
        throw Exception(error);
      },
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        _resendOtp = forceResendingToken;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        log.warning('timeout: $verificationId');
      },
      timeout: const Duration(seconds: 5),
    );
  }

  @override
  Future<void> signOut() async => await auth.signOut();

  @override
  Future<void> verifyOtp(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: otp,
    );
    await auth.signInWithCredential(credential);
  }

  @override
  String? getUser() {
    return sharedPreferences.getString('uid');
  }

  @override
  Future<void> setUserLoggedIn(String uid) {
    return sharedPreferences.setString('uid', uid);
  }

  @override
  Future<void> removeUser(String uid) {
    return sharedPreferences.remove(uid);
  }

  @override
  Future<void> resendOtp(String phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        await auth.signInWithCredential(phoneAuthCredential);
        if (kDebugMode) {
          log.fine('phone verified: Token ${phoneAuthCredential.token}');
        }
      },
      verificationFailed: (error) {
        log.severe(error);
        throw Exception(error);
      },
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        _resendOtp = forceResendingToken;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        log.warning('timeout: $verificationId');
      },
      timeout: const Duration(seconds: 5),
      forceResendingToken: _resendOtp,
    );
  }

  @override
  Future<bool> isUserExist(String uid) async {
    final users = FirebaseFirestore.instance.collection('users');
    final docSnapshot = await users.doc(uid).get();
    return docSnapshot.exists;
  }
}
