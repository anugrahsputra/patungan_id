import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppThemes with WidgetsBindingObserver {
  static ThemeData get dark {
    const brightness = Brightness.dark;
    const primaryColor = Color.fromRGBO(182, 185, 185, 1.0);
    const primaryColorDark = Color.fromRGBO(255, 255, 255, 1.0);

    const accentColor = Colors.cyan;
    const backgroundColor = Color(0xFF000000);

    return ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      primarySwatch: accentColor,
      brightness: brightness,
      primaryColorDark: primaryColorDark,
      scaffoldBackgroundColor: backgroundColor,
      dialogBackgroundColor: const Color.fromRGBO(45, 45, 45, 1.0),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(color: Colors.white),
        displayMedium: GoogleFonts.inter(color: Colors.white),
        displaySmall: GoogleFonts.inter(color: Colors.white),
        headlineLarge: GoogleFonts.inter(color: Colors.white),
        headlineMedium: GoogleFonts.inter(color: Colors.white),
        headlineSmall: GoogleFonts.inter(color: Colors.white),
        titleLarge: GoogleFonts.inter(color: Colors.white),
        titleMedium: GoogleFonts.inter(color: Colors.white),
        titleSmall: GoogleFonts.inter(color: Colors.white),
        bodyLarge: GoogleFonts.inter(color: Colors.white),
        bodyMedium: GoogleFonts.inter(color: Colors.white),
        bodySmall: GoogleFonts.inter(color: Colors.white),
        labelLarge: GoogleFonts.inter(color: accentColor),
        labelMedium: GoogleFonts.inter(color: accentColor),
        labelSmall: GoogleFonts.inter(color: accentColor),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Color.fromRGBO(42, 42, 42, 1.0),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 20),
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      cardTheme: const CardTheme(
        elevation: 2,
        color: Colors.black,
      ),
      primaryColor: primaryColor,
      cardColor: Colors.black87,
      colorScheme: const ColorScheme.dark(
        background: Colors.white12,
        secondary: accentColor,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: backgroundColor,
      ),
    );
  }

  static ThemeData get light {
    const MaterialColor kaccentColor = MaterialColor(
      0xFF2AAD7A,
      <int, Color>{
        50: Color(0xFF02174C),
        100: Color(0xFF02174C),
        200: Color(0xFF02174C),
        300: Color(0xFF02174C),
        400: Color(0xFF02174C),
        500: Color(0xFF02174C),
        600: Color(0xFF02174C),
        700: Color(0xFF02174C),
        800: Color(0xFF02174C),
        900: Color(0xFF02174C),
      },
    );

    const brightness = Brightness.light;
    const primaryColor = Colors.black;
    const primaryColorLight = Color.fromRGBO(113, 113, 113, 1.0);
    const primaryColorDark = Color.fromRGBO(0, 0, 0, 1.0);
    const accentColor = kaccentColor;
    const backgroundColor = Color(0xFFF5F5F5);

    ColorScheme customColorScheme = const ColorScheme(
      primary: primaryColor,
      secondary: Colors.white70,
      surface: Colors.white,
      background: backgroundColor,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: primaryColorLight,
      onBackground: backgroundColor,
      onError: Colors.redAccent,
      brightness: Brightness.light,
    );

    return ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      primarySwatch: accentColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,
      colorScheme: customColorScheme,
      scaffoldBackgroundColor: backgroundColor,
      dialogBackgroundColor: backgroundColor,
      brightness: brightness,
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(color: Colors.black),
        displayMedium: GoogleFonts.inter(color: Colors.black),
        displaySmall: GoogleFonts.inter(color: Colors.black),
        headlineLarge: GoogleFonts.inter(color: Colors.black),
        headlineMedium: GoogleFonts.inter(color: Colors.black),
        headlineSmall: GoogleFonts.inter(color: Colors.black),
        titleLarge: GoogleFonts.inter(color: Colors.black),
        titleMedium: GoogleFonts.inter(color: Colors.black),
        titleSmall: GoogleFonts.inter(color: Colors.black),
        bodyLarge: GoogleFonts.inter(color: Colors.black),
        bodyMedium: GoogleFonts.inter(color: Colors.black),
        bodySmall: GoogleFonts.inter(color: Colors.black),
        labelLarge: GoogleFonts.inter(color: accentColor),
        labelMedium: GoogleFonts.inter(color: accentColor),
        labelSmall: GoogleFonts.inter(color: accentColor),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Color.fromRGBO(42, 42, 42, 1.0),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 20),
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      cardTheme: const CardTheme(
        elevation: 2,
        color: Colors.white,
      ),
      primaryColor: primaryColor,
      cardColor: Colors.white,
      bottomAppBarTheme: const BottomAppBarTheme(
        color: backgroundColor,
      ),
    );
  }
}
