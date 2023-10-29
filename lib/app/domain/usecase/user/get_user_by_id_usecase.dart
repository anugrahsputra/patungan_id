import '../../domain.dart';

class GetUserByIdUsecase {
  final UserRepository userRepository;

  GetUserByIdUsecase({required this.userRepository});

  Stream<UserEntity> call(String uid) {
    return userRepository.getUserById(uid);
  }
}
