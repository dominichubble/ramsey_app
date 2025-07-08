import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'app.dart';

void main() {
  // Enable network debugging in debug mode
  if (kDebugMode) {
    debugPrint('Starting Ramsey App in debug mode');
  }
  
  runApp(const MyApp());
}
