import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class SignInUsecase {
  final AuthRepository authRepository;

  SignInUsecase(this.authRepository);

  Future<Either<Failure, void>> call(String phoneNumber) async {
    return await authRepository.signInWithPhoneNumber(phoneNumber);
  }
}
