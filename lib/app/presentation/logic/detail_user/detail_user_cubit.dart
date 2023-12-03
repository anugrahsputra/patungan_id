import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import '../../../domain/domain.dart';

part 'detail_user_cubit.freezed.dart';
part 'detail_user_state.dart';

class DetailUserCubit extends Cubit<DetailUserState> {
  final GetUserUsecase getUserUsecase;

  final Logger log = Logger("detail user cubit");

  DetailUserCubit({required this.getUserUsecase})
      : super(const DetailUserState.initial());

  Future<void> getUser(String uid) async {
    emit(const DetailUserState.loading());
    log.info('getting user ...');
    final result = await getUserUsecase.call(uid);
    result.fold((l) {
      emit(DetailUserState.error(l.message));
      log.severe('error getting user');
    }, (r) {
      emit(DetailUserState.loaded(r));
      log.fine('user loaded success!');
    });
  }
}
