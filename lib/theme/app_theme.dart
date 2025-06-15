import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the cybersecurity application.
class AppTheme {
  AppTheme._();

  // Cybersecurity color palette
  static const Color primaryGreen = Color(0xFF00E676);
  static const Color secondaryOrange = Color(0xFFFF5722);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color errorRed = Color(0xFFCF6679);
  static const Color warningAmber = Color(0xFFFFB74D);
  static const Color successGreen = Color(0xFF81C784);
  static const Color infoBlue = Color(0xFF64B5F6);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB3B3B3);

  // Additional semantic colors
  static const Color vulnerabilityHigh = Color(0xFFFF5722);
  static const Color vulnerabilityMedium = Color(0xFFFFB74D);
  static const Color vulnerabilityLow = Color(0xFF81C784);
  static const Color scanningActive = Color(0xFF00E676);
  static const Color scanningIdle = Color(0xFF64B5F6);

  // Shadow and overlay colors
  static const Color shadowDark = Color(0x1A000000);
  static const Color overlayDark = Color(0x80000000);
  static const Color dividerDark = Color(0x1FFFFFFF);

  /// Professional Dark Theme - Primary theme for cybersecurity application
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: primaryGreen,
      onPrimary: Color(0xFF000000),
      primaryContainer: Color(0xFF00C853),
      onPrimaryContainer: Color(0xFF000000),
      secondary: secondaryOrange,
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFE64A19),
      onSecondaryContainer: Color(0xFFFFFFFF),
      tertiary: infoBlue,
      onTertiary: Color(0xFF000000),
      tertiaryContainer: Color(0xFF42A5F5),
      onTertiaryContainer: Color(0xFF000000),
      error: errorRed,
      onError: Color(0xFF000000),
      surface: surfaceDark,
      onSurface: textPrimary,
      onSurfaceVariant: textSecondary,
      outline: Color(0xFF404040),
      outlineVariant: Color(0xFF2A2A2A),
      shadow: shadowDark,
      scrim: overlayDark,
      inverseSurface: Color(0xFFE0E0E0),
      onInverseSurface: Color(0xFF121212),
      inversePrimary: Color(0xFF00C853),
      surfaceTint: primaryGreen,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: surfaceDark,
    dividerColor: dividerDark,

    // AppBar theme for technical authority
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundDark,
      foregroundColor: textPrimary,
      elevation: 0,
      scrolledUnderElevation: 1,
      centerTitle: false,
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: textPrimary,
        letterSpacing: 0.15,
      ),
      iconTheme: const IconThemeData(color: textPrimary, size: 24),
      actionsIconTheme: const IconThemeData(color: primaryGreen, size: 24),
    ),

    // Card theme for adaptive cards with subtle elevation
    cardTheme: CardThemeData(
      color: surfaceDark,
      elevation: 2,
      shadowColor: shadowDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Bottom navigation for mobile-first navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: primaryGreen,
      unselectedItemColor: textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Strategic floating action button for primary security actions
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryGreen,
      foregroundColor: const Color(0xFF000000),
      elevation: 4,
      focusElevation: 6,
      hoverElevation: 6,
      highlightElevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),

    // Button themes for clear hierarchy
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF000000),
        backgroundColor: primaryGreen,
        disabledForegroundColor: textSecondary,
        disabledBackgroundColor: const Color(0xFF404040),
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryGreen,
        disabledForegroundColor: textSecondary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        side: const BorderSide(color: primaryGreen, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryGreen,
        disabledForegroundColor: textSecondary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
      ),
    ),

    // Typography for technical precision
    textTheme: _buildDarkTextTheme(),

    // Input decoration for form elements with focused states
    inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0xFF2A2A2A),
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color(0xFF404040), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color(0xFF404040), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: primaryGreen, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorRed, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorRed, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color(0xFF2A2A2A), width: 1),
      ),
      labelStyle: GoogleFonts.inter(
        color: textSecondary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      floatingLabelStyle: GoogleFonts.inter(
        color: primaryGreen,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: GoogleFonts.inter(
        color: const Color(0xFF666666),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.inter(
        color: errorRed,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      prefixIconColor: textSecondary,
      suffixIconColor: textSecondary,
    ),

    // Switch theme for security toggles
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryGreen;
        }
        return const Color(0xFF666666);
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryGreen.withAlpha(128);
        }
        return const Color(0xFF404040);
      }),
      trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
    ),

    // Checkbox theme for selection states
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryGreen;
        }
        return Colors.transparent;
      }),
      checkColor: MaterialStateProperty.all(const Color(0xFF000000)),
      side: const BorderSide(color: Color(0xFF666666), width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),

    // Radio theme for option selection
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryGreen;
        }
        return const Color(0xFF666666);
      }),
    ),

    // Progress indicators for attack progress
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryGreen,
      linearTrackColor: Color(0xFF404040),
      circularTrackColor: Color(0xFF404040),
    ),

    // Slider theme for parameter adjustment
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryGreen,
      thumbColor: primaryGreen,
      overlayColor: primaryGreen.withAlpha(51),
      inactiveTrackColor: const Color(0xFF404040),
      valueIndicatorColor: primaryGreen,
      valueIndicatorTextStyle: GoogleFonts.roboto(
        color: const Color(0xFF000000),
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Tab bar theme for navigation
    tabBarTheme: TabBarThemeData(
      labelColor: primaryGreen,
      unselectedLabelColor: textSecondary,
      indicatorColor: primaryGreen,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.25,
      ),
    ),

    // Tooltip theme for contextual help
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: const Color(0xE6000000),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        color: textPrimary,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.all(8),
    ),

    // SnackBar theme for status feedback
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFF2D2D2D),
      contentTextStyle: GoogleFonts.inter(
        color: textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: primaryGreen,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4,
    ),

    // Expansion tile theme for progressive disclosure
    expansionTileTheme: ExpansionTileThemeData(
      backgroundColor: surfaceDark,
      collapsedBackgroundColor: surfaceDark,
      iconColor: primaryGreen,
      collapsedIconColor: textSecondary,
      textColor: textPrimary,
      collapsedTextColor: textPrimary,
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // List tile theme for data display
    listTileTheme: ListTileThemeData(
      tileColor: surfaceDark,
      selectedTileColor: primaryGreen.withAlpha(26),
      iconColor: textSecondary,
      selectedColor: primaryGreen,
      textColor: textPrimary,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      subtitleTextStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textSecondary,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Chip theme for tags and filters
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF404040),
      selectedColor: primaryGreen.withAlpha(51),
      disabledColor: const Color(0xFF2A2A2A),
      labelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      secondaryLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textSecondary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      side: BorderSide.none,
    ),

    // Divider theme for content separation
    dividerTheme: const DividerThemeData(
      color: dividerDark,
      thickness: 1,
      space: 1,
    ), dialogTheme: const DialogThemeData(backgroundColor: Color(0xFF2D2D2D)),
  );

  /// Light theme (minimal implementation for fallback)
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF00C853),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFE8F5E8),
      onPrimaryContainer: Color(0xFF003300),
      secondary: Color(0xFFD84315),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFFFE0DB),
      onSecondaryContainer: Color(0xFF330800),
      tertiary: Color(0xFF1976D2),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFE3F2FD),
      onTertiaryContainer: Color(0xFF001A33),
      error: Color(0xFFD32F2F),
      onError: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF000000),
      onSurfaceVariant: Color(0xFF666666),
      outline: Color(0xFFBDBDBD),
      outlineVariant: Color(0xFFE0E0E0),
      shadow: Color(0x1A000000),
      scrim: overlayDark,
      inverseSurface: Color(0xFF121212),
      onInverseSurface: Color(0xFFFFFFFF),
      inversePrimary: primaryGreen,
      surfaceTint: Color(0xFF00C853),
    ),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    textTheme: _buildLightTextTheme(),
  );

  /// Build dark theme text styles with cybersecurity focus
  static TextTheme _buildDarkTextTheme() {
    return TextTheme(
      // Display styles for headers
      displayLarge: GoogleFonts.roboto(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        letterSpacing: -0.25,
      ),
      displayMedium: GoogleFonts.roboto(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textPrimary,
      ),
      displaySmall: GoogleFonts.roboto(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textPrimary,
      ),

      // Headline styles for section headers
      headlineLarge: GoogleFonts.roboto(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      headlineMedium: GoogleFonts.roboto(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      headlineSmall: GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),

      // Title styles for cards and dialogs
      titleLarge: GoogleFonts.roboto(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        letterSpacing: 0,
      ),
      titleMedium: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textPrimary,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textPrimary,
        letterSpacing: 0.0,
      ),

      // Body styles for general text
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        letterSpacing: 0.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        letterSpacing: 0.25,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        letterSpacing: 0.4,
      ),

      // Label styles for buttons and form fields
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textPrimary,
        letterSpacing: 1.25,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textPrimary,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textPrimary,
        letterSpacing: 0.5,
      ),

      // Custom styles for specific elements
      // Example: For terminal output
      // terminalOutput: GoogleFonts.monospace(
      //   fontSize: 14,
      //   color: primaryGreen,
      // ),
    );
  }

  /// Build light theme text styles
  static TextTheme _buildLightTextTheme() {
    return TextTheme(
      displayLarge: GoogleFonts.roboto(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF000000),
        letterSpacing: -0.25,
      ),
      displayMedium: GoogleFonts.roboto(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF000000),
      ),
      displaySmall: GoogleFonts.roboto(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF000000),
      ),
      headlineLarge: GoogleFonts.roboto(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF000000),
      ),
      headlineMedium: GoogleFonts.roboto(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF000000),
      ),
      headlineSmall: GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF000000),
      ),
      titleLarge: GoogleFonts.roboto(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF000000),
        letterSpacing: 0,
      ),
      titleMedium: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF000000),
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF000000),
        letterSpacing: 0.0,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF000000),
        letterSpacing: 0.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF000000),
        letterSpacing: 0.25,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF000000),
        letterSpacing: 0.4,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF000000),
        letterSpacing: 1.25,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF000000),
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF000000),
        letterSpacing: 0.5,
      ),
    );
  }

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'high':
        return vulnerabilityHigh;
      case 'medium':
        return vulnerabilityMedium;
      case 'low':
        return vulnerabilityLow;
      case 'active':
        return scanningActive;
      case 'idle':
        return scanningIdle;
      default:
        return textSecondary;
    }
  }

  static TextStyle get monospaceLarge => GoogleFonts.robotoMono(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      );

  static TextStyle get monospaceSmall => GoogleFonts.robotoMono(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textPrimary,
      );
}


