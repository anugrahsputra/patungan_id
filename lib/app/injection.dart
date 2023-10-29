import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:patungan_id/app/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/core.dart';
import 'domain/repository/repository.dart';
import 'domain/usecase/auth/auth.dart';
import 'domain/usecase/setting/setting.dart';
import 'domain/usecase/user/user.dart';
import 'presentation/presentation.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /*-------------------> EXTERNAL <-------------------*/
  final sharedPref = await SharedPreferences.getInstance();
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);
  sl.registerLazySingleton(() => sharedPref);

  /*-------------------> CORE <-------------------*/
  sl.registerSingleton<AppNavigator>(AppNavigator());
  sl.registerSingleton<ChangeThemeMode>(ChangeThemeModeImpl());

  /*-------------------> CUBIT <-------------------*/
  // AuthCubit
  sl.registerFactory(() => AuthCubit(
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
      ));
  sl.registerFactory(() => SplashCubit(auth: sl(), currentUser: sl()));
  sl.registerFactory(
      () => SettingCubit(getThemeModeUsecase: sl(), themeModeUsecase: sl()));
  sl.registerFactory(() => UserCubit(
        currentUserIdUsecase: sl(),
        userByIdUsecase: sl(),
        currentUserUsecase: sl(),
      ));

  /*-------------------> USECASE <-------------------*/
  // auth
  sl.registerLazySingleton(() => SignInUsecase(sl()));
  sl.registerLazySingleton(() => SignOutUsecase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUsecase(sl()));
  // sl.registerLazySingleton(() => GetCurrentUerUsecase(sl()));
  sl.registerLazySingleton(() => GetCachedUserUsecase(sl()));
  // sl.registerLazySingleton(() => GetCurrentIdUsecase(sl()));
  sl.registerLazySingleton(() => SaveToDatabaseUsecase(sl()));
  // sl.registerLazySingleton(() => GetUserByIdUsecase(sl()));
  sl.registerLazySingleton(() => ResendOtpUsecase(sl()));

  // setting
  sl.registerLazySingleton(() => GetLocalThemeModeUsecase(
        settingRepository: sl(),
      ));
  sl.registerLazySingleton(
      () => ChangeThemeModeUsecase(settingRepository: sl()));

  // user
  sl.registerLazySingleton(() => GetCurrentIdUsecase(userRepository: sl()));
  sl.registerLazySingleton(() => GetCurrentUserUsecase(userRepository: sl()));
  sl.registerLazySingleton(() => GetUserByIdUsecase(userRepository: sl()));

  /*-------------------> REPOSITORY <-------------------*/
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<SettingRepository>(() => SettingRepositoryImpl(
        settingProvider: sl(),
      ));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        userProvider: sl(),
      ));

  /*-------------------> PROVIDER <-------------------*/
  // auth
  sl.registerLazySingleton<AuthProvider>(
      () => AuthProviderImpl(auth, firestore, sharedPref));

  // setting
  sl.registerLazySingleton<SettingProvider>(() => SettingProviderImpl(
        sharedPreferences: sharedPref,
        themes: sl<ChangeThemeMode>(),
      ));

  // user
  sl.registerLazySingleton<UserProvider>(() => UserProviderImpl(
        auth: auth,
        firestore: firestore,
      ));
}
