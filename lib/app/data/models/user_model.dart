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
      phoneNumber: map['phoneNumber'],
      name: map['name'],
      profilePic: map['profilePic'],
      groupId: List<String>.from(map['groupId']),
      friendsId: List<String>.from(map['friendsId']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'profilePic': profilePic,
      'groupId': groupId,
      'friendsId': friendsId,
    };
  }
}
