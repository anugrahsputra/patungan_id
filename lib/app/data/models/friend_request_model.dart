import '../../domain/domain.dart';

class FriendRequestModel extends FriendRequest {
  const FriendRequestModel({
    required super.id,
    required super.senderId,
    required super.receiverId,
    required super.status,
  });

  factory FriendRequestModel.fromMap(Map<String, dynamic> map) {
    return FriendRequestModel(
      id: map['id'],
      senderId: map['sender_id'],
      receiverId: map['receiver_id'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'sender_id': senderId,
        'receiver_id': receiverId,
        'status': status,
      };

  @override
  List<Object?> get props => [id, senderId, receiverId, status];
}
