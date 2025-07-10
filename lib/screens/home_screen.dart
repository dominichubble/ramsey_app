import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/home_events.dart';
import '../widgets/home_food_and_drink.dart';
import '../widgets/home_highlights.dart';
import '../widgets/home_news.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Welcome to Ramsey',
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search action
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Handle profile action
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            HomeNews(),
            HomeHighlights(),
            HomeEvents(),
            HomeFoodAndDrink(),
          ],
        ),
      ),
    );
  }
}
