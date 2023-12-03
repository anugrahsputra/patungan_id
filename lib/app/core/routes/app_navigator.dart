import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../core.dart';

class AppNavigator {
  final Logger log = Logger('App Navigator');

  bool canPop(BuildContext context) => Navigator.of(context).canPop();

  bool isCurrentPage(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent == true;

  bool canNavigate(BuildContext context) {
    if (context.mounted) {
      return true;
    } else {
      log.warning("Cannot navigate because the context is unmounted");
      return false;
    }
  }

  void back<T>(BuildContext context, {T? result}) {
    if (canPop(context)) Navigator.of(context).pop(context);
  }

  void goToSplah(BuildContext context) {
    if (!canNavigate(context)) return;

    Navigator.of(context).pushNamedAndRemoveUntil(
      AppPages.splash,
      (route) => false,
    );
  }

  void goToAuth(BuildContext context) {
    if (!canNavigate(context)) return;

    Navigator.of(context).pushNamed(AppPages.login);
  }

  void goToVerify(BuildContext context, {required String phoneNumber}) {
    if (!canNavigate(context)) return;

    Navigator.of(context).pushNamed(AppPages.verify, arguments: {
      "phoneNumber": phoneNumber,
    });
  }

  void goToLoading(BuildContext context) {
    if (!canNavigate(context)) return;

    Navigator.of(context).pushNamed(AppPages.loading);
  }

  void goToSetupProfile(BuildContext context) {
    if (!canNavigate(context)) return;

    Navigator.of(context).pushNamed(AppPages.setupProfile);
  }

  void goToHome(BuildContext context) {
    if (!canNavigate(context)) return;

    Navigator.of(context).pushNamedAndRemoveUntil(
      AppPages.home,
      (route) => false,
    );
  }

  void goToProfile(BuildContext context) {
    if (!canNavigate(context)) return;

    Navigator.of(context).pushNamed(AppPages.profile);
  }

  void gotoQrCode(BuildContext context, {required String data}) {
    if (!canNavigate(context)) return;

    Navigator.of(context).pushNamed(AppPages.qrcode, arguments: {
      'data': data,
    });
  }

  void goToQrScanPage(BuildContext context) {
    if (!canNavigate(context)) return;

    Navigator.of(context).pushNamed(AppPages.qrscan);
  }

  void notFound(BuildContext context) {
    if (!canNavigate(context)) return;

    Navigator.of(context).pushNamed(AppPages.notFound);
  }
}
