import 'package:flutter/material.dart';
import 'package:ramsey_app/constants/colours.dart';

class TextStyles {
  // Heading 1 style based on your CSS
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'Comfortaa',
    fontSize: 16,
    height: 1.625, // line-height: 26px / font-size: 16px = 1.625
    fontWeight: FontWeight.w700,
    color: AppColours.text, // Assuming primary color is used for headings
  );

  // You can add more text styles here
  static const TextStyle heading2 = TextStyle(
    fontFamily: 'Comfortaa',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColours.text,
  );

  static const TextStyle bodyText = TextStyle(
    fontFamily: 'Comfortaa',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColours.text,
  );
}
