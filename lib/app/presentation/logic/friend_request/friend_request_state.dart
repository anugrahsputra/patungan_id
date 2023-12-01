part of 'friend_request_cubit.dart';

@freezed
class FriendRequestState with _$FriendRequestState {
  const factory FriendRequestState.initial() = _Initial;
  const factory FriendRequestState.loading() = _Loading;
  const factory FriendRequestState.accepFriendReq() = _AcceptFriendReq;
  const factory FriendRequestState.rejectFriendReq() = _RejectFriendReq;
  const factory FriendRequestState.sendFriendReq() = _SendFriendReq;

  const factory FriendRequestState.error(String message) = _Error;
}
