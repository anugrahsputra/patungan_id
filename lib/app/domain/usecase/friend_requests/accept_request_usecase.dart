import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class AcceptRequestUsecase {
  final UserRepository userRepository;

  AcceptRequestUsecase({required this.userRepository});

  Future<Either<Failure, void>> call(String requestId) {
    return userRepository.acceptFriendRequest(requestId);
  }
}
