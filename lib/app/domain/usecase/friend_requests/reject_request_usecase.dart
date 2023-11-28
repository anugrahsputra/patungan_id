import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class RejectRequestUsecase {
  final UserRepository userRepository;

  RejectRequestUsecase({required this.userRepository});

  Future<Either<Failure, void>> call(String requestId) {
    return userRepository.rejectFriendRequest(requestId);
  }
}
