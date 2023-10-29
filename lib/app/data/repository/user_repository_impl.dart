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
}
