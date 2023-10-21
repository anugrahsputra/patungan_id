import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:patungan_id/app/data/data.dart';
import 'package:patungan_id/app/data/repository/auth_repository_impl.dart';

import 'core/core.dart';
import 'domain/domain.dart';
import 'presentation/presentation.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /*-------------------> EXTERNAL <-------------------*/
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);

  /*-------------------> CORE <-------------------*/
  sl.registerSingleton<AppNavigator>(AppNavigator());

  /*-------------------> CUBIT <-------------------*/
  // AuthCubit
  sl.registerFactory(() => AuthCubit(sl(), sl(), sl()));
  sl.registerFactory(() => SplashCubit(auth: sl()));

  /*-------------------> USECASE <-------------------*/
  // auth
  sl.registerLazySingleton(() => SignInUsecase(sl()));
  sl.registerLazySingleton(() => SignOutUsecase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUsecase(sl()));

  /*-------------------> REPOSITORY <-------------------*/
  // auth
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  /*-------------------> PROVIDER <-------------------*/
  // auth
  sl.registerLazySingleton<AuthProvider>(() => AuthProviderImpl(sl(), sl()));
}
