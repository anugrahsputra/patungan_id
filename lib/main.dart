import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:patungan_id/app/bloc_observer.dart';
import 'package:patungan_id/firebase_options.dart';

import 'app/core/core.dart';
import 'app/injection.dart';
import 'app/presentation/presentation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _Logging.initialize(showLog: true);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AuthCubit authCubit = sl<AuthCubit>();
  final SettingCubit settingCubit = sl<SettingCubit>();

  final Logger log = Logger("Themes");

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthCubit>()..getCurrentUser()),
        BlocProvider(create: (context) => settingCubit),
      ],
      child: GetMaterialApp(
        title: 'Patungan Id',
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        themeMode: settingCubit.state.when(
          initial: (themeMode) => themeMode,
          loading: (themeMode) => themeMode,
          success: (themeMode) {
            log.fine('themeMode: $themeMode');
            return themeMode;
          },
          error: (_) =>
              ThemeMode.system, // default to system theme mode in case of error
        ),
        initialRoute: AppRoutes.initial,
        routes: AppRoutes.routes,
      ),
    );
  }
}

abstract class _Logging {
  static bool isInitialize = false;

  static Future<void> initialize({bool showLog = false}) async {
    if (!_Logging.isInitialize) {
      Logger.root.level = showLog ? Level.ALL : Level.OFF;

      Logger.root.onRecord.listen((record) {
        final level = record.level;
        final name = record.loggerName;
        final message = record.message;
        final strackTrace = record.stackTrace;
        final error = record.error;

        if (level == Level.FINE ||
            level == Level.FINER ||
            level == Level.FINEST) {
          log('✅ ${level.name} "$name" : $message');
        } else if (level == Level.SEVERE ||
            level == Level.SHOUT ||
            level == Level.WARNING) {
          log('⛔ ${level.name} "$name" : $message${error != null ? '\nError : $error' : ''}${strackTrace != null ? '\n$strackTrace' : ''}');
        } else if (level == Level.INFO || level == Level.CONFIG) {
          log('ℹ️ ${level.name} "$name" : $message');
        }
      });

      _Logging.isInitialize = true;
    }
  }
}
