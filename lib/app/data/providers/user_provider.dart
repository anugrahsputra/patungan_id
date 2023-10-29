import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';

import '../data.dart';

abstract class UserProvider {
  Future<String> getCurrentId();
  Future<UserModel> getCurrentUser();
  Stream<UserModel> getUserById(String uid);
  Future<bool> isUserExist(String uid);
}

class UserProviderImpl implements UserProvider {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UserProviderImpl({required this.auth, required this.firestore});

  final Logger log = Logger("User Provider");

  @override
  Future<String> getCurrentId() async => auth.currentUser!.uid;

  @override
  Future<UserModel> getCurrentUser() async {
    var userData =
        await firestore.collection("users").doc(await getCurrentId()).get();
    return UserModel.fromMap(userData.data()!);
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
  Future<bool> isUserExist(String uid) async {
    final users = FirebaseFirestore.instance.collection('users');
    final docSnapshot = await users.doc(uid).get();
    return docSnapshot.exists;
  }
}
