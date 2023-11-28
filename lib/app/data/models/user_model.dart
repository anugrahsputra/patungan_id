import '../../domain/domain.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.phoneNumber,
    required super.name,
    required super.profilePic,
    required super.groupId,
    required super.friendsId,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      phoneNumber: map['phone_number'],
      name: map['name'],
      profilePic: map['profile_pic'],
      groupId: List<String>.from(map['group_id']),
      friendsId: List<String>.from(map['friends_id']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phone_number': phoneNumber,
      'name': name,
      'profile_pic': profilePic,
      'group_id': groupId,
      'friends_id': friendsId,
    };
  }
}
