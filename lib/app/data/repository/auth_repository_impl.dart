import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:patungan_id/app/core/errors/failure.dart';

import '../../domain/domain.dart';
import '../data.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthProvider authProvider;

  AuthRepositoryImpl(this.authProvider);

  @override
  Future<Either<Failure, String>> getCurrentId() async {
    try {
      final result = await authProvider.getCurrentId();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final result = await authProvider.getCurrentUser();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Stream<UserEntity> getUserById(String uid) {
    return authProvider.getUserById(uid);
  }

  @override
  Future<Either<Failure, void>> saveDataToDatabase(String name) async {
    try {
      final result = await authProvider.saveDataToDatabase(name);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> signInWithPhoneNumber(
      String phoneNumber) async {
    try {
      final result = await authProvider.signInWithPhoneNumber(phoneNumber);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final result = await authProvider.signOut();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp(String otp) async {
    try {
      final result = await authProvider.verifyOtp(otp);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }
}
