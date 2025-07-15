import 'package:flutter/material.dart';
import 'color_scheme.dart';

class ThemeUtils {
  // Easy access to colors
  static ColorScheme getColors(BuildContext context) {
    return Theme.of(context).colorScheme;
  }
  
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
  
  static bool isLightMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }
  
  // Semantic color getters
  static Color getIncomeColor(BuildContext context) {
    return UpanziKashColors.incomeColor;
  }
  
  static Color getExpenseColor(BuildContext context) {
    return UpanziKashColors.expenseColor;
  }
  
  static Color getProfitColor(BuildContext context) {
    return UpanziKashColors.profitColor;
  }
  
  static Color getNeutralColor(BuildContext context) {
    return UpanziKashColors.neutralColor;
  }
  
  // Farming-specific colors
  static Color getCropColor(BuildContext context) {
    return UpanziKashColors.cropColor;
  }
  
  static Color getLivestockColor(BuildContext context) {
    return UpanziKashColors.livestockColor;
  }
  
  static Color getDairyColor(BuildContext context) {
    return UpanziKashColors.dairyColor;
  }
  
  static Color getFertilizerColor(BuildContext context) {
    return UpanziKashColors.fertilizerColor;
  }
  
  static Color getWaterColor(BuildContext context) {
    return UpanziKashColors.waterColor;
  }
  
  static Color getTransportColor(BuildContext context) {
    return UpanziKashColors.transportColor;
  }
  
  static Color getLaborColor(BuildContext context) {
    return UpanziKashColors.laborColor;
  }
  
  // Weather colors
  static Color getSunnyColor(BuildContext context) {
    return UpanziKashColors.sunnyColor;
  }
  
  static Color getCloudyColor(BuildContext context) {
    return UpanziKashColors.cloudyColor;
  }
  
  static Color getRainyColor(BuildContext context) {
    return UpanziKashColors.rainyColor;
  }
  
  static Color getHotColor(BuildContext context) {
    return UpanziKashColors.hotColor;
  }
  
  static Color getColdColor(BuildContext context) {
    return UpanziKashColors.coldColor;
  }
  
  // Text styles
  static TextStyle getHeadlineStyle(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge!;
  }
  
  static TextStyle getTitleStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!;
  }
  
  static TextStyle getBodyStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!;
  }
  
  static TextStyle getCaptionStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!;
  }
  
  // Spacing constants
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  
  // Border radius constants
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;
  
  // Elevation constants
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;
  static const double elevationXL = 16.0;
  
  // Animation durations
  static const Duration durationFast = Duration(milliseconds: 200);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);
  
  // Helper methods for common UI patterns
  static BoxDecoration getCardDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(radiusL),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).shadowColor.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
  
  static BoxDecoration getGradientDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: UpanziKashColors.primaryGradient,
      borderRadius: BorderRadius.circular(radiusL),
    );
  }
  
  static InputDecoration getInputDecoration(BuildContext context, String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusM),
      ),
      filled: true,
      fillColor: Theme.of(context).inputDecorationTheme.fillColor,
    );
  }
  
  // Responsive helpers
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }
  
  static bool isMediumScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1200;
  }
  
  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }
  
  // Accessibility helpers
  static bool isHighContrast(BuildContext context) {
    return MediaQuery.of(context).highContrast;
  }
  
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }
  
  // Platform-specific helpers
  static bool isIOS(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS;
  }
  
  static bool isAndroid(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.android;
  }
} 