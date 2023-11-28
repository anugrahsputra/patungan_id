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
}
