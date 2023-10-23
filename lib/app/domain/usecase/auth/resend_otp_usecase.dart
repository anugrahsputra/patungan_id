import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class ResendOtpUsecase {
  final AuthRepository authRepository;

  ResendOtpUsecase(this.authRepository);

  Future<Either<Failure, void>> call(String phoneNumber) async {
    return await authRepository.resendOtp(phoneNumber);
  }
}
