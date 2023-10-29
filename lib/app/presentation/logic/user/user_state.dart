part of 'user_cubit.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.loaded(UserEntity? userEntity) = _Loaded;
  const factory UserState.redirect() = _Redirect;
  const factory UserState.error(String message) = _Error;
}
