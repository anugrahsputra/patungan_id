import 'package:flutter/material.dart';

import '../../presentation/presentation.dart';
import '../core.dart';

abstract class AppRoutes {
  static String get initial => AppPages.splash;

  static final Map<String, Widget Function(BuildContext context)> routes = {
    AppPages.splash: (context) => const SplashPage(),

    /* ----------------------- AUTH ----------------------- */
    AppPages.setupProfile: (context) => const SetupProfilePage(),
    AppPages.login: (context) => const AuthPage(),
    AppPages.verify: (context) {
      Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      String phoneNumber = arguments["phoneNumber"];
      return VerifyOtpPage(phoneNumber: phoneNumber);
    },
    AppPages.loading: (context) => const LoadingPage(),

    /* ----------------------- MAIN ----------------------- */
    AppPages.home: (context) => const Homepage(),
    AppPages.profile: (context) => const ProfilePage(),
    AppPages.qrcode: (context) {
      Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      String data = arguments['data'];
      String profilePic = arguments['profile_pic'];
      return QrCodePage(
        data: data,
        profilePic: profilePic,
      );
    },
    AppPages.qrscan: (context) => const QrScanPage(),
    AppPages.addFriend: (context) {
      Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      String friendId = arguments['friend_id'];
      return AddFriendPage(friendId: friendId);
    },
    /* ----------------------- REDIRECT ----------------------- */
    AppPages.notFound: (context) => const NotFoundPage(),
  };
}
