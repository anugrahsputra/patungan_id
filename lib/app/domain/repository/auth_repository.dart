import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signInWithPhoneNumber(String phoneNumber);
  Future<Either<Failure, void>> verifyOtp(String otp);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, void>> saveDataToDatabase(String name);
  Future<Either<Failure, String>> getCurrentId();
  Future<Either<Failure, String>> getCachedLocalCurrentUid();
  Future<Either<Failure, UserModel>> getCurrentUser();
  Stream<UserEntity> getUserById(String uid);
}
