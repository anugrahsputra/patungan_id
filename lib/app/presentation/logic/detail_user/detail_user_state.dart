part of 'detail_user_cubit.dart';

@freezed
class DetailUserState with _$DetailUserState {
  const factory DetailUserState.initial() = _Initial;
  const factory DetailUserState.loading() = _Loading;
  const factory DetailUserState.loaded(UserEntity? userEntity) = _Loeaded;
  const factory DetailUserState.error(String message) = _Error;
}
