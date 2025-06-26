import 'package:ramsey_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:ramsey_app/constants/colours.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ramsey App',
      theme: ThemeData(
        primaryColor: AppColours.primary,
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: AppColours.textSecondary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            color: AppColours.textPrimary,
            fontSize: 20,
          ),
        ),
      ),
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}
