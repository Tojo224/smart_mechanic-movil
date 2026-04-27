import 'package:flutter/material.dart';

class AppTheme {
  // Paleta de Colores Metálica (Inspirada en pintura automotriz de alta gama)
  static const gunmetalGrey = Color(0xFF24292E);
  static const midnightBlue = Color(0xFF1B262C);
  static const chromeSilver = Color(0xFFB0B3B8);
  static const electricBlue = Color(0xFF3282B8);
  static const deepOcean = Color(0xFF0F4C75);
  static const charcoal = Color(0xFF121212);

  static LinearGradient metallicGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF2C3E50),
      Color(0xFF000000),
    ],
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: charcoal,
    colorScheme: const ColorScheme.dark(
      primary: electricBlue,
      secondary: chromeSilver,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
    ),
    
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20, 
        fontWeight: FontWeight.bold, 
        letterSpacing: 1.2,
        color: chromeSilver,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: electricBlue,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 58),
        elevation: 8,
        shadowColor: electricBlue.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2A2A2A),
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      prefixIconColor: chromeSilver,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.05), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: electricBlue, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    ),

    cardTheme: const CardThemeData(
      color: Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      elevation: 4,
    ),
  );
}
