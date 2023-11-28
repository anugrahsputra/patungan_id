import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> getCurrentId();
  Future<Either<Failure, UserModel>> getCurrentUser();
  Future<Either<Failure, UserModel>> getUser(String uid);
  Stream<UserEntity> getUserById(String uid);
  Future<Either<Failure, void>> addFriend(String friendId);
  Stream<List<FriendRequest>> getFriendRequest();
  Future<Either<Failure, void>> acceptFriendRequest(String requestId);
  Future<Either<Failure, void>> rejectFriendRequest(String requestId);
}
