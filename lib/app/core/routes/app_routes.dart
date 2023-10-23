import 'package:flutter/material.dart';

import '../../presentation/presentation.dart';
import '../core.dart';

abstract class AppRoutes {
  static String get initial => AppPages.splash;

  static final Map<String, Widget Function(BuildContext context)> routes = {
    AppPages.splash: (context) => const SplashPage(),
    AppPages.home: (context) => const Homepage(),
    AppPages.login: (context) => AuthPage(),
    AppPages.verify: (context) {
      Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      String phoneNumber = arguments["phoneNumber"];
      return VerifyOtpPage(phoneNumber: phoneNumber);
    }
  };
}
