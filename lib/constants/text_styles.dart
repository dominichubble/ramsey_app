import 'package:flutter/material.dart';
import 'package:ramsey_app/constants/colours.dart';

// Comprehensive typography system for Ramsey App
class TextStyles {
  // Font family constant
  static const String _fontFamily = 'Comfortaa';

  // Display Text Styles (Large headings)
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    height: 1.4,
    fontWeight: FontWeight.w700,
    color: AppColours.heading,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    height: 1.4,
    fontWeight: FontWeight.w700,
    color: AppColours.heading,
  );

  // Heading Text Styles
  static const TextStyle heading1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: AppColours.heading,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    height: 1.4,
    fontWeight: FontWeight.w600,
    color: AppColours.heading,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    height: 1.4,
    fontWeight: FontWeight.w600,
    color: AppColours.heading,
  );

  static const TextStyle heading4 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    height: 1.3,
    fontWeight: FontWeight.w600,
    color: AppColours.heading,
  );

  static const TextStyle heading5 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    height: 1.3,
    fontWeight: FontWeight.w600,
    color: AppColours.heading,
  );

  // Body Text Styles
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColours.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    height: 1.4,
    fontWeight: FontWeight.w400,
    color: AppColours.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    height: 1.3,
    fontWeight: FontWeight.w400,
    color: AppColours.textPrimary,
  );

  // Label Text Styles
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    height: 1.2,
    fontWeight: FontWeight.w500,
    color: AppColours.textPrimary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    height: 1.2,
    fontWeight: FontWeight.w500,
    color: AppColours.textPrimary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10,
    height: 1.2,
    fontWeight: FontWeight.w500,
    color: AppColours.textSecondary,
  );

  // App Bar Text Styles
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColours.textInverse,
  );

  static const TextStyle appBarSubtitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColours.textInverse,
  );

  // Button Text Styles
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColours.textInverse,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColours.textInverse,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColours.textInverse,
  );

  // Card Text Styles
  static const TextStyle cardTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColours.textPrimary,
  );

  static const TextStyle cardSubtitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColours.textSecondary,
  );

  static const TextStyle cardCaption = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColours.textTertiary,
  );

  // Feature-specific Text Styles
  static const TextStyle newsTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColours.textPrimary,
  );

  static const TextStyle newsDescription = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    height: 1.4,
    fontWeight: FontWeight.w400,
    color: AppColours.textSecondary,
  );

  static const TextStyle newsDate = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColours.dateText,
  );

  static const TextStyle eventTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColours.textPrimary,
  );

  static const TextStyle eventDate = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColours.dateText,
  );

  static const TextStyle restaurantName = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColours.textPrimary,
  );

  static const TextStyle restaurantCuisine = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColours.textSecondary,
  );

  static const TextStyle restaurantLocation = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColours.textTertiary,
  );

  // Badge and Tag Text Styles
  static const TextStyle badge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColours.textInverse,
  );

  static const TextStyle tag = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColours.textSecondary,
  );

  // Link Text Styles
  static const TextStyle link = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColours.link,
    decoration: TextDecoration.underline,
  );

  static const TextStyle linkSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColours.link,
    decoration: TextDecoration.underline,
  );

  // Error and Status Text Styles
  static const TextStyle error = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColours.error,
  );

  static const TextStyle success = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColours.success,
  );

  static const TextStyle warning = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColours.warning,
  );

  // Legacy styles (keeping for backward compatibility)
  static const TextStyle bodyText = bodyMedium;
}
