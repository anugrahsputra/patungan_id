import '../../domain.dart';

class GetFriendRequestUsecase {
  final UserRepository userRepository;

  GetFriendRequestUsecase({required this.userRepository});

  Stream<List<FriendRequest>> call() => userRepository.getFriendRequest();
}
