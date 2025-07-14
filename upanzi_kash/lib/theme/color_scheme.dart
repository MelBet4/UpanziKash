import 'package:flutter/material.dart';

class UpanziKashColors {
  // Brand Colors
  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color accentOrange = Color(0xFFFF8F00);
  static const Color creamBackground = Color(0xFFFFFBF2);
  static const Color darkBrownText = Color(0xFF3E2723);
  
  // Additional Brand Colors
  static const Color lightGreen = Color(0xFF4CAF50);
  static const Color darkGreen = Color(0xFF1B5E20);
  static const Color lightOrange = Color(0xFFFFB74D);
  static const Color darkOrange = Color(0xFFE65100);
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color mediumGrey = Color(0xFF9E9E9E);
  static const Color darkGrey = Color(0xFF424242);
  static const Color black = Color(0xFF000000);
  
  // Status Colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color errorRed = Color(0xFFF44336);
  static const Color infoBlue = Color(0xFF2196F3);
  
  // Light Theme Colors
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primaryGreen,
    onPrimary: white,
    secondary: accentOrange,
    onSecondary: white,
    tertiary: lightGreen,
    onTertiary: white,
    error: errorRed,
    onError: white,
    background: creamBackground,
    onBackground: darkBrownText,
    surface: white,
    onSurface: darkBrownText,
    surfaceVariant: lightGrey,
    onSurfaceVariant: darkBrownText,
    outline: mediumGrey,
    outlineVariant: lightGrey,
    shadow: Color(0x1F000000),
    scrim: Color(0x52000000),
    inverseSurface: darkGrey,
    onInverseSurface: white,
    inversePrimary: lightGreen,
    surfaceTint: primaryGreen,
  );
  
  // Dark Theme Colors
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: lightGreen,
    onPrimary: black,
    secondary: lightOrange,
    onSecondary: black,
    tertiary: primaryGreen,
    onTertiary: white,
    error: Color(0xFFEF5350),
    onError: black,
    background: Color(0xFF121212),
    onBackground: white,
    surface: Color(0xFF1E1E1E),
    onSurface: white,
    surfaceVariant: Color(0xFF2D2D2D),
    onSurfaceVariant: Color(0xFFE0E0E0),
    outline: mediumGrey,
    outlineVariant: darkGrey,
    shadow: Color(0x00000000),
    scrim: Color(0x52000000),
    inverseSurface: white,
    onInverseSurface: black,
    inversePrimary: darkGreen,
    surfaceTint: lightGreen,
  );
  
  // Custom Color Extensions
  static Color get incomeColor => successGreen;
  static Color get expenseColor => errorRed;
  static Color get profitColor => infoBlue;
  static Color get neutralColor => mediumGrey;
  
  // Outdoor Readability Colors (High Contrast)
  static const Color outdoorText = Color(0xFF1A1A1A);
  static const Color outdoorBackground = Color(0xFFFFF8E1);
  static const Color outdoorSurface = Color(0xFFFFFDE7);
  static const Color outdoorPrimary = Color(0xFF1B5E20);
  static const Color outdoorSecondary = Color(0xFFE65100);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryGreen, lightGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [accentOrange, lightOrange],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [creamBackground, white],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Opacity Variants
  static Color primaryGreenWithOpacity(double opacity) => 
      primaryGreen.withOpacity(opacity);
  
  static Color accentOrangeWithOpacity(double opacity) => 
      accentOrange.withOpacity(opacity);
  
  static Color darkBrownWithOpacity(double opacity) => 
      darkBrownText.withOpacity(opacity);
  
  // Semantic Colors for Farming Context
  static Color get cropColor => successGreen;
  static Color get livestockColor => Color(0xFF8D6E63);
  static Color get dairyColor => Color(0xFFE3F2FD);
  static Color get fertilizerColor => Color(0xFF795548);
  static Color get waterColor => Color(0xFF2196F3);
  static Color get transportColor => Color(0xFFFF9800);
  static Color get laborColor => Color(0xFF607D8B);
  
  // Weather Colors
  static Color get sunnyColor => Color(0xFFFFEB3B);
  static Color get cloudyColor => Color(0xFFBDBDBD);
  static Color get rainyColor => Color(0xFF2196F3);
  static Color get hotColor => Color(0xFFFF5722);
  static Color get coldColor => Color(0xFF03A9F4);
} 