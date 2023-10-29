import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class GetCurrentIdUsecase {
  final UserRepository userRepository;

  GetCurrentIdUsecase({required this.userRepository});

  Future<Either<Failure, String>> call() async {
    return await userRepository.getCurrentId();
  }
}
