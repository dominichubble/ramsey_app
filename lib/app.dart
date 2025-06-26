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
        secondaryHeaderColor: AppColours.secondary,
      ),
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}
