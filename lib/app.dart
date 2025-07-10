import 'package:flutter/material.dart';
import 'package:ramsey_app/constants/colours.dart';
import 'package:ramsey_app/constants/text_styles.dart';
import 'package:ramsey_app/routes.dart';

// Main app with comprehensive Ramsey design system
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ramsey App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Primary color scheme
        primarySwatch: MaterialColor(AppColours.primary.value, <int, Color>{
          50: AppColours.primaryLight.withValues(alpha: 0.1),
          100: AppColours.primaryLight.withValues(alpha: 0.2),
          200: AppColours.primaryLight.withValues(alpha: 0.3),
          300: AppColours.primaryLight.withValues(alpha: 0.4),
          400: AppColours.primaryLight.withValues(alpha: 0.5),
          500: AppColours.primary,
          600: AppColours.primary.withValues(alpha: 0.8),
          700: AppColours.primaryDark.withValues(alpha: 0.9),
          800: AppColours.primaryDark,
          900: AppColours.primaryDark.withValues(alpha: 0.8),
        }),
        primaryColor: AppColours.primary,

        // Color scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColours.primary,
          primary: AppColours.primary,
          secondary: AppColours.primaryLight,
          surface: AppColours.surface,
          background: AppColours.background,
          error: AppColours.error,
          onPrimary: AppColours.textInverse,
          onSecondary: AppColours.textPrimary,
          onSurface: AppColours.textPrimary,
          onBackground: AppColours.textPrimary,
          onError: AppColours.textInverse,
        ),

        // Background colors
        scaffoldBackgroundColor: AppColours.background,
        canvasColor: AppColours.surface,

        // Typography theme using our custom text styles
        textTheme: const TextTheme(
          // Display styles
          displayLarge: TextStyles.displayLarge,
          displayMedium: TextStyles.displayMedium,
          displaySmall: TextStyles.heading1,

          // Headline styles
          headlineLarge: TextStyles.heading1,
          headlineMedium: TextStyles.heading2,
          headlineSmall: TextStyles.heading3,

          // Title styles
          titleLarge: TextStyles.heading4,
          titleMedium: TextStyles.heading5,
          titleSmall: TextStyles.cardTitle,

          // Body styles
          bodyLarge: TextStyles.bodyLarge,
          bodyMedium: TextStyles.bodyMedium,
          bodySmall: TextStyles.bodySmall,

          // Label styles
          labelLarge: TextStyles.labelLarge,
          labelMedium: TextStyles.labelMedium,
          labelSmall: TextStyles.labelSmall,
        ),

        // App bar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColours.primary,
          foregroundColor: AppColours.textInverse,
          elevation: 0,
          titleTextStyle: TextStyles.appBarTitle,
          toolbarTextStyle: TextStyles.appBarSubtitle,
          iconTheme: IconThemeData(color: AppColours.textInverse, size: 24),
        ),

        // Card theme
        cardTheme: CardThemeData(
          color: AppColours.cardBackground,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),

        // Button themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColours.primary,
            foregroundColor: AppColours.textInverse,
            textStyle: TextStyles.buttonMedium,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColours.primary,
            textStyle: TextStyles.buttonMedium.copyWith(
              color: AppColours.primary,
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColours.primary,
            textStyle: TextStyles.buttonMedium.copyWith(
              color: AppColours.primary,
            ),
            side: const BorderSide(color: AppColours.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColours.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColours.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColours.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColours.error),
          ),
          labelStyle: TextStyles.labelMedium,
          hintStyle: TextStyles.bodyMedium.copyWith(
            color: AppColours.textTertiary,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),

        // Icon theme
        iconTheme: const IconThemeData(
          color: AppColours.textSecondary,
          size: 24,
        ),

        // Chip theme
        chipTheme: const ChipThemeData(
          backgroundColor: AppColours.surfaceVariant,
          labelStyle: TextStyles.tag,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),

        // Divider theme
        dividerTheme: const DividerThemeData(
          color: AppColours.border,
          thickness: 1,
          space: 1,
        ),

        // Bottom navigation bar theme
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColours.surface,
          selectedItemColor: AppColours.primary,
          unselectedItemColor: AppColours.textTertiary,
          selectedLabelStyle: TextStyles.labelSmall.copyWith(
            color: AppColours.primary,
          ),
          unselectedLabelStyle: TextStyles.labelSmall,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),

        // Use Material 3
        useMaterial3: true,
      ),

      // Routes
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}
