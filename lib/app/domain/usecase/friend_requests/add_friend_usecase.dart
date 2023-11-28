import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class AddFriendUsecase {
  final UserRepository userRepository;

  AddFriendUsecase({required this.userRepository});

  Future<Either<Failure, void>> call(String friendId) {
    return userRepository.addFriend(friendId);
  }
}
