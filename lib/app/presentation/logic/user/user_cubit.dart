import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import '../../../domain/domain.dart';

part 'user_cubit.freezed.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetCurrentUserUsecase currentUserUsecase;
  final GetUserByIdUsecase userByIdUsecase;
  final GetCurrentIdUsecase currentUserIdUsecase;
  final GetUserUsecase getUserUsecase;

  UserCubit({
    required this.currentUserUsecase,
    required this.userByIdUsecase,
    required this.currentUserIdUsecase,
    required this.getUserUsecase,
  }) : super(const UserState.initial());

  static UserCubit get(context) => BlocProvider.of(context);

  final Logger log = Logger("user cubit");

  UserEntity? userEntity;

  Future<void> getCurrentUser() async {
    emit(const UserState.loading());
    try {
      log.info("getting current user...");
      final result = await currentUserUsecase.call();
      result.fold(
        (fail) {
          emit(UserState.error(fail.message));
          log.severe('error getting current user!');
        },
        (user) {
          userEntity = user;
          emit(UserState.loaded(userEntity));
          log.fine('current user loaded success!');
        },
      );
    } catch (e) {
      log.warning("User data is not exist for this user");
      emit(const UserState.redirect());
    }
  }

  Future<void> getUser(String uid) async {
    emit(const UserState.loading());
    log.info('getting user ...');
    final result = await getUserUsecase.call(uid);
    result.fold((l) {
      emit(UserState.error(l.message));
      log.severe('error getting user');
    }, (r) {
      emit(UserState.userLoaded(r));
      log.fine('user loaded success!');
    });
  }

  Stream<UserEntity> getUserById(String uid) {
    return userByIdUsecase.call(uid);
  }
}
