import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class GetCurrentIdUsecase {
  final AuthRepository authRepository;

  GetCurrentIdUsecase(this.authRepository);

  Future<Either<Failure, String>> call() async {
    return await authRepository.getCurrentId();
  }
}
