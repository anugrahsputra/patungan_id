import 'package:flutter/material.dart';

abstract class AppColors {
  static Color get backGroundDark => const Color.fromRGBO(17, 17, 17, 1.0);

  /* -------------------------> ADDITIONAL COLOR <--------------------------- */
  static Color get yellowNormal => const Color.fromRGBO(250, 216, 38, 1);
  static Color get yellowLight => const Color.fromRGBO(255, 252, 240, 1);
  static Color get greenNormal => const Color.fromRGBO(34, 197, 94, 1);
  static Color get greenLight => const Color.fromRGBO(244, 252, 249, 1);
  static Color get redNormal => const Color.fromRGBO(226, 46, 46, 1);
  static Color get redLight => const Color.fromRGBO(253, 244, 245, 1);
  static Color get terquoiseNormal => const Color.fromRGBO(35, 210, 179, 1);
  static Color get terquoiseLight => const Color.fromRGBO(240, 251, 251, 1);
  static Color get purpleNormal => const Color.fromRGBO(179, 83, 255, 1);
  static Color get purpleLight => const Color.fromRGBO(247, 242, 252, 1);
  static Color get blueNormal => const Color.fromRGBO(58, 146, 221, 1);
  static Color get blueLight => const Color.fromRGBO(247, 251, 255, 1);

  /* -------------------------> BACKGROUND COLOR <--------------------------- */
  static Color get backgroundPrimaryLight =>
      const Color.fromRGBO(18, 16, 16, 1);
  static Color get backgroundPrimaryDark =>
      const Color.fromRGBO(255, 255, 255, 1);
  static Color get backgroundSecondaryLight =>
      const Color.fromRGBO(83, 83, 83, 1);
  static Color get backgroundSecondaryDark =>
      const Color.fromRGBO(245, 245, 245, 1);
  static Color get backgroundTertiaryLight =>
      const Color.fromRGBO(119, 119, 119, 1);
  static Color get backgroundTertiaryDark =>
      const Color.fromRGBO(119, 119, 119, 1);
  static Color get backgroundQuarternaryLight =>
      const Color.fromRGBO(205, 203, 206, 1);
  static Color get backgroundQuarternaryDark =>
      const Color.fromRGBO(83, 83, 83, 1);
  static Color get backgroundQuinaryLight =>
      const Color.fromRGBO(217, 217, 217, 1);
  static Color get backgroundQuinaryDark => const Color.fromRGBO(37, 37, 37, 1);
  static Color get backgroundSenaryLight =>
      const Color.fromRGBO(236, 236, 236, 1);
  static Color get backgroundSenaryDark => const Color.fromRGBO(29, 30, 44, 1);
  static Color get backgroundSeptenaryLight =>
      const Color.fromRGBO(248, 248, 248, 1);
  static Color get backgroundSeptenaryDark =>
      const Color.fromRGBO(25, 26, 39, 1);
  static Color get backgroundOctonaryLight =>
      const Color.fromRGBO(255, 255, 255, 1);
  static Color get backgroundOctonaryDark =>
      const Color.fromRGBO(18, 16, 16, 1);

  /* ----------------------------> TEXT COLOR <------------------------------ */
  static Color get textPrimaryLight => const Color.fromRGBO(17, 16, 16, 1);
  static Color get textPrimaryDark => const Color.fromRGBO(255, 255, 255, 1);
  static Color get textSecondaryLight => const Color.fromRGBO(119, 119, 119, 1);
  static Color get textSecondaryDark => const Color.fromRGBO(166, 169, 172, 1);
  static Color get textTertiaryLight => const Color.fromRGBO(176, 175, 178, 1);
  static Color get textTertiaryDark => const Color.fromRGBO(117, 119, 122, 1);
  static Color get textQuarternaryLight =>
      const Color.fromRGBO(255, 255, 255, 1);
  static Color get textQuarternaryDark => const Color.fromRGBO(21, 22, 34, 1);

  /* ---------------------------> SHADES COLOR <----------------------------- */
  static Color get shadesBlack100 => const Color.fromRGBO(0, 0, 0, 1);
  static Color get shadesBlack92 => const Color.fromRGBO(0, 0, 0, 0.92);
  static Color get shadesBlack84 => const Color.fromRGBO(0, 0, 0, 0.84);
  static Color get shadesBlack72 => const Color.fromRGBO(0, 0, 0, 0.72);
  static Color get shadesBlack64 => const Color.fromRGBO(0, 0, 0, 0.64);
  static Color get shadesBlack48 => const Color.fromRGBO(0, 0, 0, 0.48);
  static Color get shadesBlack24 => const Color.fromRGBO(0, 0, 0, 0.24);
  static Color get shadesBlack16 => const Color.fromRGBO(0, 0, 0, 0.16);
  static Color get shadesBlack8 => const Color.fromRGBO(0, 0, 0, 0.08);
  static Color get shadesBlack4 => const Color.fromRGBO(0, 0, 0, 0.04);

  static Color get shadesWhite100 => const Color.fromRGBO(255, 255, 255, 1);
  static Color get shadesWhite92 => const Color.fromRGBO(255, 255, 255, 0.92);
  static Color get shadesWhite84 => const Color.fromRGBO(255, 255, 255, 0.84);
  static Color get shadesWhite72 => const Color.fromRGBO(255, 255, 255, 0.72);
  static Color get shadesWhite64 => const Color.fromRGBO(255, 255, 255, 0.64);
  static Color get shadesWhite48 => const Color.fromRGBO(255, 255, 255, 0.48);
  static Color get shadesWhite24 => const Color.fromRGBO(255, 255, 255, 0.24);
  static Color get shadesWhite16 => const Color.fromRGBO(255, 255, 255, 0.16);
  static Color get shadesWhite8 => const Color.fromRGBO(255, 255, 255, 0.08);
  static Color get shadesWhite4 => const Color.fromRGBO(255, 255, 255, 0.04);
}
