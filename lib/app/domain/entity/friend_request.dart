import 'package:equatable/equatable.dart';

class FriendRequest extends Equatable {
  final String id;
  final String senderId;
  final String receiverId;
  final String status;

  const FriendRequest({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.status,
  });

  @override
  List<Object?> get props => [id, senderId, receiverId, status];
}
