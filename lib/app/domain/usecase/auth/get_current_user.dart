import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class GetCurrentUerUsecase {
  final AuthRepository authRepository;

  GetCurrentUerUsecase(this.authRepository);

  Future<Either<Failure, UserEntity>> call() async {
    return await authRepository.getCurrentUser();
  }
}
