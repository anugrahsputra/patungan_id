import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialog {
  late BuildContext context;
  AppDialog(this.context);

  static bool? get isOpened => Get.isDialogOpen;

  Future<void> showLoadingPanel() async {
    await Get.generalDialog(
      barrierDismissible: false,
      pageBuilder: (context, animation, secondaryAnimation) =>
          const Center(child: CircularProgressIndicator()),
    );
  }

  static Future<void> waitUntilClosed() async {
    while (isOpened == true) {
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }

  Future<void> close() async {
    await waitUntilClosed();

    if (context.mounted && ModalRoute.of(context)?.isCurrent != true) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
