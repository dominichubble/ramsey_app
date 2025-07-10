import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double width;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width == double.infinity ? null : width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0, // Removed shadow
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: width == double.infinity
              ? const Size(double.infinity, 40)
              : null,
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
