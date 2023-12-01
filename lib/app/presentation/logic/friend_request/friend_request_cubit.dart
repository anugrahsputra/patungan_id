import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/domain.dart';

part 'friend_request_cubit.freezed.dart';
part 'friend_request_state.dart';

class FriendRequestCubit extends Cubit<FriendRequestState> {
  final AddFriendUsecase addFriendUsecase;
  final AcceptRequestUsecase acceptRequestUsecase;
  final RejectRequestUsecase rejectRequestUsecase;
  final GetFriendRequestUsecase getFriendRequestUsecase;
  FriendRequestCubit({
    required this.addFriendUsecase,
    required this.acceptRequestUsecase,
    required this.rejectRequestUsecase,
    required this.getFriendRequestUsecase,
  }) : super(const FriendRequestState.initial());

  void addFriend(String friendId) async {
    emit(const FriendRequestState.loading());
    final result = await addFriendUsecase.call(friendId);
    result.fold(
      (fail) => emit(FriendRequestState.error(fail.message)),
      (success) => emit(const FriendRequestState.sendFriendReq()),
    );
  }

  void acceptFriendReq(String reqId) async {
    emit(const FriendRequestState.loading());
    final result = await acceptRequestUsecase.call(reqId);
    result.fold(
      (fail) => emit(FriendRequestState.error(fail.message)),
      (success) => emit(const FriendRequestState.accepFriendReq()),
    );
  }

  void rejectFriendReq(String reqId) async {
    emit(const FriendRequestState.loading());
    final result = await rejectRequestUsecase.call(reqId);
    result.fold(
      (fail) => emit(FriendRequestState.error(fail.message)),
      (success) => emit(const FriendRequestState.rejectFriendReq()),
    );
  }

  Stream<List<FriendRequest>> getFriendReq() {
    return getFriendRequestUsecase.call();
  }
}
