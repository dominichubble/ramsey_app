import 'package:ramsey_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:ramsey_app/constants/colours.dart';
import 'package:ramsey_app/constants/text_styles.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ramsey App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColours.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColours.primary,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyles.bodyText,
          bodyMedium: TextStyles.bodyText,
          headlineLarge: TextStyles.heading1,
          headlineMedium: TextStyles.heading2,
        ),
      ),
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}
