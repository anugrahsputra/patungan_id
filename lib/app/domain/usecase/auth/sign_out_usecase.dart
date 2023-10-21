import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class SignOutUsecase {
  final AuthRepository authRepository;

  SignOutUsecase(this.authRepository);

  Future<Either<Failure, void>> call() async {
    return await authRepository.signOut();
  }
}
