part of 'friend_request_cubit.dart';

@freezed
class FriendRequestState with _$FriendRequestState {
  const factory FriendRequestState.initial() = _Initial;
  const factory FriendRequestState.loading() = _Loading;
  const factory FriendRequestState.loaded(FriendRequest friendRequest) =
      _Loaded;
  const factory FriendRequestState.error(String message) = _Error;
}
