import 'package:flutter/material.dart';

import '../../presentation/presentation.dart';
import '../core.dart';

abstract class AppRoutes {
  static String get initial => AppPages.splash;

  static final Map<String, Widget Function(BuildContext context)> routes = {
    AppPages.splash: (context) => const SplashPage(),
    AppPages.home: (context) => const Homepage(),
    AppPages.login: (context) => AuthPage(),
  };
}
