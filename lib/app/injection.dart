import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:patungan_id/app/data/data.dart';
import 'package:patungan_id/app/domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/core.dart';
import 'presentation/presentation.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /*-------------------> EXTERNAL <-------------------*/
  final sharedPref = await SharedPreferences.getInstance();
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);
  sl.registerLazySingleton(() => storage);
  sl.registerLazySingleton(() => sharedPref);

  /*-------------------> CORE <-------------------*/
  sl.registerSingleton<AppNavigator>(AppNavigator());
  sl.registerSingleton<AppSettings>(AppSettingsImpl());

  /*-------------------> CUBIT <-------------------*/
  // AuthCubit
  sl.registerFactory(() => AuthCubit(
        signInUsecase: sl<SignInUsecase>(),
        verifyOtpUsecase: sl<VerifyOtpUsecase>(),
        signOutUsecase: sl<SignOutUsecase>(),
        currentUerUsecase: sl<GetCurrentUserUsecase>(),
        cachedUserUsecase: sl<GetCachedUserUsecase>(),
        saveToDatabaseUsecase: sl<SaveToDatabaseUsecase>(),
        userByIdUsecase: sl<GetUserByIdUsecase>(),
        currentUserIdUsecase: sl<GetCurrentIdUsecase>(),
        resendOtpUsecase: sl<ResendOtpUsecase>(),
        profilePicUsecase: sl<GetDefaultProfilePicUsecase>(),
      ));
  sl.registerFactory(() => SplashCubit(
        auth: sl(),
        currentUser: sl(),
      ));
  sl.registerFactory(() => SettingCubit(
        getThemeModeUsecase: sl(),
        themeModeUsecase: sl(),
      ));
  sl.registerFactory(() => UserCubit(
        currentUserIdUsecase: sl(),
        userByIdUsecase: sl(),
        currentUserUsecase: sl(),
      ));
  sl.registerFactory(() => FriendRequestCubit(
        addFriendUsecase: sl<AddFriendUsecase>(),
        acceptRequestUsecase: sl<AcceptRequestUsecase>(),
        rejectRequestUsecase: sl<RejectRequestUsecase>(),
        getFriendRequestUsecase: sl<GetFriendRequestUsecase>(),
      ));

  /*-------------------> USECASE <-------------------*/
  // auth
  sl.registerLazySingleton(() => SignInUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignOutUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => VerifyOtpUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => GetCachedUserUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SaveToDatabaseUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => ResendOtpUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton(
      () => AddFriendUsecase(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton(
      () => RejectRequestUsecase(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton(
      () => AcceptRequestUsecase(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton(
      () => GetFriendRequestUsecase(userRepository: sl<UserRepository>()));

  // setting
  sl.registerLazySingleton(() => GetLocalThemeModeUsecase(
        settingRepository: sl(),
      ));
  sl.registerLazySingleton(() => AppSettingsUsecase(settingRepository: sl()));

  // user
  sl.registerLazySingleton(
      () => GetCurrentIdUsecase(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton(
      () => GetCurrentUserUsecase(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton(
      () => GetUserByIdUsecase(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton(
      () => GetDefaultProfilePicUsecase(repository: sl<StorageRepository>()));

  /*-------------------> REPOSITORY <-------------------*/
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl<AuthenticationProvider>()));
  sl.registerLazySingleton<SettingRepository>(() => SettingRepositoryImpl(
        settingProvider: sl<SettingProvider>(),
      ));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        userProvider: sl<UserProvider>(),
      ));
  sl.registerLazySingleton<StorageRepository>(
      () => StorageRepositoryImpl(storageProvider: sl<StorageProvider>()));

  /*-------------------> PROVIDER <-------------------*/
  // auth
  sl.registerLazySingleton<AuthenticationProvider>(
      () => AuthenticationProviderImpl(auth, firestore, sharedPref));

  // setting
  sl.registerLazySingleton<SettingProvider>(() => SettingProviderImpl(
        sharedPreferences: sharedPref,
        themes: sl<AppSettings>(),
      ));

  // user
  sl.registerLazySingleton<UserProvider>(() => UserProviderImpl(
        auth: auth,
        firestore: firestore,
      ));

  // storage
  sl.registerLazySingleton<StorageProvider>(
      () => StorageProviderImpl(storage: storage));
}
