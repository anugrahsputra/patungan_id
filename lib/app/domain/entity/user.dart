import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String phoneNumber;
  final String name;
  final String profilePic;
  final List<String> groupId;
  final List<String> friendsId;

  const UserEntity({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.profilePic,
    required this.groupId,
    required this.friendsId,
  });

  @override
  List<Object?> get props => [
        id,
        phoneNumber,
        name,
        profilePic,
        groupId,
        friendsId,
      ];
}
