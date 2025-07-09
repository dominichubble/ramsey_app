import 'package:flutter/material.dart';
import 'package:ramsey_app/constants/colours.dart';

class TextStyles {
  // Appbar title style based on your CSS
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: 'Comfortaa',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white, // Assuming white is used for app bar titles
  );
  // Heading 1 style based on your CSS
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'Comfortaa',
    fontSize: 24,
    height: 1.5, // line-height: 36px / font-size: 24px = 1.5
    fontWeight: FontWeight.w700,
    color: AppColours.heading,
  );

  // You can add more text styles here
  static const TextStyle heading2 = TextStyle(
    fontFamily: 'Comfortaa',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle bodyText = TextStyle(
    fontFamily: 'Comfortaa',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
}
