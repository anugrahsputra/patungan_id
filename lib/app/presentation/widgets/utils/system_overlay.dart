import 'package:flutter/services.dart';

import '../../../core/core.dart';
import '../../../injection.dart';

class SystemOverlay {
  static final AppSettings theme = sl<AppSettings>();

  static void updateSystemOverlay() {
    SystemChrome.setSystemUIOverlayStyle(getSystemOverlay());
  }

  static SystemUiOverlayStyle getSystemOverlay() {
    return theme.isDarkMode()
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;
  }
}
