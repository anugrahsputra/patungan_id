import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class VerifyOtpUsecase {
  final AuthRepository authRepository;

  VerifyOtpUsecase(this.authRepository);

  Future<Either<Failure, void>> call(String otp) async {
    return await authRepository.verifyOtp(otp);
  }
}
