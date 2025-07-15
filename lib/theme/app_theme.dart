import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

class UpanziKashTheme {
  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: UpanziKashColors.lightColorScheme,
      scaffoldBackgroundColor: UpanziKashColors.creamBackground,
      // (For gradients, use BoxDecoration in main screens)
      
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: UpanziKashColors.primaryGreen,
        foregroundColor: UpanziKashColors.white,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          color: UpanziKashColors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: UpanziKashColors.white,
          size: 24,
        ),
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: UpanziKashColors.white,
        selectedItemColor: UpanziKashColors.primaryGreen,
        unselectedItemColor: UpanziKashColors.mediumGrey,
        type: BottomNavigationBarType.fixed,
        elevation: 16, // More shadow
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        showUnselectedLabels: true,
      ),
      // (For floating/rounded nav bar, use a custom widget in main screens)
      
      // Card Theme
      cardTheme: CardThemeData(
        color: UpanziKashColors.white,
        elevation: 8, // Increased for more depth
        shadowColor: UpanziKashColors.primaryGreen.withOpacity(0.10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), // More rounded
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: UpanziKashColors.primaryGreen,
          foregroundColor: UpanziKashColors.white,
          elevation: 4, // More shadow
          shadowColor: UpanziKashColors.primaryGreen.withOpacity(0.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18), // More rounded
          ),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: UpanziKashColors.primaryGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: UpanziKashColors.primaryGreen,
          side: const BorderSide(
            color: UpanziKashColors.primaryGreen,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: UpanziKashColors.accentOrange,
        foregroundColor: UpanziKashColors.white,
        elevation: 6,
        shape: CircleBorder(),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: UpanziKashColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: UpanziKashColors.primaryGreen,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: UpanziKashColors.primaryGreen,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: UpanziKashColors.accentOrange,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: UpanziKashColors.errorRed,
            width: 1.5,
          ),
        ),
        labelStyle: const TextStyle(
          color: UpanziKashColors.darkBrownText,
          fontSize: 16,
        ),
        hintStyle: TextStyle(
          color: UpanziKashColors.darkBrownText.withOpacity(0.6),
          fontSize: 16,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      
      // Text Theme
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: UpanziKashColors.darkBrownText,
            letterSpacing: -0.5,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: UpanziKashColors.darkBrownText,
            letterSpacing: -0.5,
          ),
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: UpanziKashColors.darkBrownText,
          ),
          headlineLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: UpanziKashColors.darkBrownText,
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: UpanziKashColors.darkBrownText,
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: UpanziKashColors.darkBrownText,
          ),
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UpanziKashColors.darkBrownText,
          ),
          titleMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: UpanziKashColors.darkBrownText,
          ),
          titleSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: UpanziKashColors.darkBrownText,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: UpanziKashColors.darkBrownText,
            height: 1.5,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: UpanziKashColors.darkBrownText,
            height: 1.5,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: UpanziKashColors.darkBrownText,
            height: 1.4,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: UpanziKashColors.darkBrownText,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: UpanziKashColors.darkBrownText,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: UpanziKashColors.darkBrownText,
          ),
        ),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: UpanziKashColors.primaryGreen,
        size: 24,
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: UpanziKashColors.lightGrey,
        selectedColor: UpanziKashColors.primaryGreen,
        disabledColor: UpanziKashColors.mediumGrey,
        labelStyle: const TextStyle(
          color: UpanziKashColors.darkBrownText,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 1,
        pressElevation: 2,
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: UpanziKashColors.lightGrey,
        thickness: 1,
        space: 1,
      ),
      
      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: UpanziKashColors.primaryGreen,
        linearTrackColor: UpanziKashColors.lightGrey,
        circularTrackColor: UpanziKashColors.lightGrey,
      ),
      
      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return UpanziKashColors.primaryGreen;
          }
          return UpanziKashColors.mediumGrey;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return UpanziKashColors.primaryGreen.withOpacity(0.5);
          }
          return UpanziKashColors.lightGrey;
        }),
      ),
      
      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: UpanziKashColors.darkBrownText,
        contentTextStyle: const TextStyle(
          color: UpanziKashColors.white,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      
      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: UpanziKashColors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titleTextStyle: const TextStyle(
          color: UpanziKashColors.darkBrownText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: const TextStyle(
          color: UpanziKashColors.darkBrownText,
          fontSize: 16,
        ),
      ),
      
      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: UpanziKashColors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      ),
      
      // List Tile Theme
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        titleTextStyle: TextStyle(
          color: UpanziKashColors.darkBrownText,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        subtitleTextStyle: TextStyle(
          color: UpanziKashColors.darkBrownText,
          fontSize: 14,
        ),
        iconColor: UpanziKashColors.primaryGreen,
      ),
    );
  }
  
  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: UpanziKashColors.darkColorScheme,
      
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: UpanziKashColors.darkGrey,
        foregroundColor: UpanziKashColors.white,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          color: UpanziKashColors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: UpanziKashColors.white,
          size: 24,
        ),
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: UpanziKashColors.darkGrey,
        selectedItemColor: UpanziKashColors.lightOrange,
        unselectedItemColor: UpanziKashColors.mediumGrey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        color: UpanziKashColors.darkGrey,
        elevation: 4,
        shadowColor: UpanziKashColors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: UpanziKashColors.lightGreen,
          foregroundColor: UpanziKashColors.black,
          elevation: 2,
          shadowColor: UpanziKashColors.lightGreen.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: UpanziKashColors.lightGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: UpanziKashColors.lightGreen,
          side: const BorderSide(
            color: UpanziKashColors.lightGreen,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: UpanziKashColors.lightOrange,
        foregroundColor: UpanziKashColors.black,
        elevation: 6,
        shape: CircleBorder(),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: UpanziKashColors.darkGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: UpanziKashColors.lightGreen,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: UpanziKashColors.lightGreen,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: UpanziKashColors.lightOrange,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: UpanziKashColors.errorRed,
            width: 1.5,
          ),
        ),
        labelStyle: const TextStyle(
          color: UpanziKashColors.white,
          fontSize: 16,
        ),
        hintStyle: TextStyle(
          color: UpanziKashColors.white.withOpacity(0.6),
          fontSize: 16,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      
      // Text Theme (Dark)
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: UpanziKashColors.white,
            letterSpacing: -0.5,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: UpanziKashColors.white,
            letterSpacing: -0.5,
          ),
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: UpanziKashColors.white,
          ),
          headlineLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: UpanziKashColors.white,
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: UpanziKashColors.white,
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: UpanziKashColors.white,
          ),
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: UpanziKashColors.white,
          ),
          titleMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: UpanziKashColors.white,
          ),
          titleSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: UpanziKashColors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: UpanziKashColors.white,
            height: 1.5,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: UpanziKashColors.white,
            height: 1.5,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: UpanziKashColors.white,
            height: 1.4,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: UpanziKashColors.white,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: UpanziKashColors.white,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: UpanziKashColors.white,
          ),
        ),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: UpanziKashColors.lightGreen,
        size: 24,
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: UpanziKashColors.darkGrey,
        selectedColor: UpanziKashColors.lightGreen,
        disabledColor: UpanziKashColors.darkGrey,
        labelStyle: const TextStyle(
          color: UpanziKashColors.white,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 1,
        pressElevation: 2,
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: UpanziKashColors.darkGrey,
        thickness: 1,
        space: 1,
      ),
      
      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: UpanziKashColors.lightGreen,
        linearTrackColor: UpanziKashColors.darkGrey,
        circularTrackColor: UpanziKashColors.darkGrey,
      ),
      
      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return UpanziKashColors.lightGreen;
          }
          return UpanziKashColors.mediumGrey;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return UpanziKashColors.lightGreen.withOpacity(0.5);
          }
          return UpanziKashColors.darkGrey;
        }),
      ),
      
      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: UpanziKashColors.darkGrey,
        contentTextStyle: const TextStyle(
          color: UpanziKashColors.white,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      
      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: UpanziKashColors.darkGrey,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titleTextStyle: const TextStyle(
          color: UpanziKashColors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: const TextStyle(
          color: UpanziKashColors.white,
          fontSize: 16,
        ),
      ),
      
      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: UpanziKashColors.darkGrey,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      ),
      
      // List Tile Theme
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        titleTextStyle: TextStyle(
          color: UpanziKashColors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        subtitleTextStyle: TextStyle(
          color: UpanziKashColors.white,
          fontSize: 14,
        ),
        iconColor: UpanziKashColors.lightGreen,
      ),
    );
  }
  
  // Outdoor Mode Theme (High Contrast for Sunlight)
  static ThemeData get outdoorTheme {
    return lightTheme.copyWith(
      colorScheme: lightTheme.colorScheme.copyWith(
        background: UpanziKashColors.outdoorBackground,
        surface: UpanziKashColors.outdoorSurface,
        primary: UpanziKashColors.outdoorPrimary,
        secondary: UpanziKashColors.outdoorSecondary,
        onBackground: UpanziKashColors.outdoorText,
        onSurface: UpanziKashColors.outdoorText,
      ),
      textTheme: lightTheme.textTheme.apply(
        bodyColor: UpanziKashColors.outdoorText,
        displayColor: UpanziKashColors.outdoorText,
      ),
      cardTheme: lightTheme.cardTheme.copyWith(
        color: UpanziKashColors.outdoorSurface,
        elevation: 8,
        shadowColor: UpanziKashColors.outdoorText.withOpacity(0.2),
      ),
    );
  }
} 