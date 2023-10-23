import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class GetCurrentUserIdUsecase {
  final AuthRepository authRepository;

  GetCurrentUserIdUsecase(this.authRepository);

  Future<Either<Failure, String>> call() async {
    return await authRepository.getCurrentId();
  }
}
