import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class GetUserUsecase {
  final UserRepository userRepository;

  GetUserUsecase({required this.userRepository});

  Future<Either<Failure, UserEntity>> call(String uid) {
    return userRepository.getUser(uid);
  }
}
