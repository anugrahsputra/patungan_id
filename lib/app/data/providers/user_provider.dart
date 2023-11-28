import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

import '../data.dart';

abstract class UserProvider {
  Future<String> getCurrentId();
  Future<UserModel> getCurrentUser();
  Stream<UserModel> getUserById(String uid);
  Future<bool> isUserExist(String uid);
  Future<void> addFriend(String friendId);
  Stream<List<FriendRequestModel>> getFriendRequests();
  Future<void> acceptFriendRequest(String requestId);
  Future<void> rejectFriendRequest(String requestId);
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

  @override
  Future<void> acceptFriendRequest(String requestId) async {
    final requestSnapshot =
        await firestore.collection('friend_requests').doc(requestId).get();

    if (!requestSnapshot.exists) {
      throw Exception("Friend request not found.");
    }

    final currentUserId = await getCurrentId();
    final senderId = requestSnapshot['sender_id'];

    await firestore
        .collection('users')
        .doc(currentUserId)
        .collection('friend_requests')
        .doc(requestId)
        .update({'status': 'accepted'});
    await firestore.collection('users').doc(currentUserId).update({
      'friends_id': FieldValue.arrayUnion([senderId])
    });
    await firestore.collection('users').doc(senderId).update({
      'friends_id': FieldValue.arrayUnion([currentUserId])
    });
  }

  @override
  Future<void> addFriend(String friendId) async {
    final currentUserId = await getCurrentId();
    final isFriendExist = await isUserExist(friendId);
    var uuid = const Uuid().v4();

    var data = FriendRequestModel(
      id: uuid,
      senderId: currentUserId,
      receiverId: friendId,
      status: 'pending',
    );

    if (!isFriendExist) {
      throw Exception('User with $friendId is not exist');
    }

    await firestore.collection('users').doc(currentUserId).update({
      'friends_id': FieldValue.arrayUnion([friendId])
    });

    await firestore
        .collection('users')
        .doc(currentUserId)
        .collection('friend_requests')
        .add(data.toMap());
  }

  @override
  Stream<List<FriendRequestModel>> getFriendRequests() {
    final currentUserId = getCurrentId();
    return firestore
        .collection('friend_requests')
        .where('receiver_id', isEqualTo: currentUserId)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => FriendRequestModel.fromMap(doc.data()))
            .toList());
  }

  @override
  Future<void> rejectFriendRequest(String requestId) async {
    await firestore
        .collection('friend_requests')
        .doc(requestId)
        .update({'status': 'rejected'});
  }
}
