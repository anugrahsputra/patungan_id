import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class GetCurrentUserUsecase {
  final UserRepository userRepository;

  GetCurrentUserUsecase({required this.userRepository});

  Future<Either<Failure, UserEntity>> call() async {
    return await userRepository.getCurrentUser();
  }
}
