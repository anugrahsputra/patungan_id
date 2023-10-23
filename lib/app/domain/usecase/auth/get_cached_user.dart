import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class GetCachedUserUsecase {
  final AuthRepository authRepository;

  GetCachedUserUsecase(this.authRepository);

  Future<Either<Failure, String>> call() async {
    return await authRepository.getCachedLocalCurrentUid();
  }
}
