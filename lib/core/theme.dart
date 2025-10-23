import 'package:flutter/material.dart';

class AppColors {
  // Colores principales
  static const Color primaryBlue = Color(0xFF1565C0);
  static const Color primaryRed = Color(0xFFD32F2F);

  // Colores para tema claro
  static const Color lightBackground = Colors.white;
  static const Color lightSurface = Color(0xFFF5F5F5);
  static const Color lightPrimaryText = Colors.black87;
  static const Color lightSecondaryText = Colors.grey;

  // Colores para tema oscuro
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkPrimaryText = Colors.white;
  static const Color darkSecondaryText = Colors.grey;

  // Colores de mensajes (mismo para ambos temas)
  static const Color userMessageBg = primaryBlue;
  static const Color botMessageBg = primaryRed;
  static final Color systemMessageBg = Colors.orange.shade600;
  static const Color messageText = Colors.white;

  // Gradientes
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryRed, primaryBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient backgroundGradient(bool isDark) => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: isDark
        ? [
            primaryBlue.withOpacity(0.15),
            darkBackground,
            primaryRed.withOpacity(0.15),
          ]
        : [
            primaryBlue.withOpacity(0.05),
            lightBackground,
            primaryRed.withOpacity(0.05),
          ],
  );
}

class AppThemes {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      secondary: AppColors.primaryRed,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    cardTheme: CardThemeData(color: AppColors.lightSurface, elevation: 2),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryBlue),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
      ),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      secondary: AppColors.primaryRed,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    cardTheme: CardThemeData(color: AppColors.darkSurface, elevation: 2),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryBlue),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
      ),
    ),
  );
}

class AppStyles {
  // Estilos de texto que se adaptan al tema
  static TextStyle headerStyle(BuildContext context) => TextStyle(
    color: Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkPrimaryText
        : AppColors.lightPrimaryText,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static const TextStyle messageStyle = TextStyle(
    fontSize: 16,
    color: AppColors.messageText,
    height: 1.4,
  );

  static TextStyle hintStyle(BuildContext context) => TextStyle(
    color: Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkSecondaryText
        : AppColors.lightSecondaryText,
  );

  // Decoraciones
  static BoxDecoration cardDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration gradientButtonDecoration = BoxDecoration(
    gradient: AppColors.primaryGradient,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryBlue.withOpacity(0.3),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

class AppDimensions {
  // Padding y margins
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  // Border radius
  static const double defaultRadius = 12.0;
  static const double largeRadius = 20.0;
  static const double circularRadius = 25.0;

  // Tamaños de iconos
  static const double smallIcon = 18.0;
  static const double defaultIcon = 24.0;
  static const double largeIcon = 64.0;
}
