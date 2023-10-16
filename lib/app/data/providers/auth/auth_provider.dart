import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../data.dart';

abstract class AuthProvider {
  Future<void> signInWithPhoneNumber(String phoneNumber);
  Future<void> verifyOtp(String otp);
  Future<void> signOut();
  Future<void> saveDataToDatabase(String name);
  Future<String> getCurrentId();
  Future<UserModel> getCurrentUser();
  Stream<UserModel> getUserById(String uid);
}

class AuthProviderImpl implements AuthProvider {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  String _verificationId = '';

  final Logger log = Logger("Auth Provider");

  AuthProviderImpl(this.auth, this.firestore);

  @override
  Future<String> getCurrentId() async => auth.currentUser!.uid;

  @override
  Future<UserModel> getCurrentUser() async {
    var userData =
        await firestore.collection('users').doc(await getCurrentId()).get();
    if (userData.exists) {
      UserModel user = UserModel.fromMap(userData.data()!);
      return user;
    } else {
      throw Exception('User data not found');
    }
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
      },
      codeAutoRetrievalTimeout: (verificationId) {
        log.warning('timeout: $verificationId');
      },
      timeout: const Duration(minutes: 1),
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
}
