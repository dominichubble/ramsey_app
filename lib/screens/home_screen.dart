import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Home Screen'),
      body: Center(child: Text('Welcome to the Home Screen!')),
    );
  }
}
