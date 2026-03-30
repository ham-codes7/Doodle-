import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get themeData {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFFDFBF7),
      primaryColor: const Color(0xFF6B5B95),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6B5B95),
        primary: const Color(0xFF6B5B95),
        secondary: const Color(0xFFFFD1DC),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      useMaterial3: true,
    );
  }
}
