import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';
import '../data.dart';

class UserRepositoryImpl implements UserRepository {
  final UserProvider userProvider;

  UserRepositoryImpl({required this.userProvider});

  @override
  Future<Either<Failure, String>> getCurrentId() async {
    try {
      final result = await userProvider.getCurrentId();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final result = await userProvider.getCurrentUser();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Stream<UserEntity> getUserById(String uid) => userProvider.getUserById(uid);

  @override
  Future<Either<Failure, void>> acceptFriendRequest(String requestId) async {
    try {
      final result = await userProvider.acceptFriendRequest(requestId);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> addFriend(String friendId) async {
    try {
      final result = await userProvider.addFriend(friendId);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Stream<List<FriendRequest>> getFriendRequest() =>
      userProvider.getFriendRequests();

  @override
  Future<Either<Failure, void>> rejectFriendRequest(String requestId) async {
    try {
      final result = await userProvider.rejectFriendRequest(requestId);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUser(String uid) async {
    try {
      final result = await userProvider.getUser(uid);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }
}
