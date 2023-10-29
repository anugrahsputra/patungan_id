import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> getCurrentId();
  Future<Either<Failure, UserModel>> getCurrentUser();
  Stream<UserEntity> getUserById(String uid);
}
