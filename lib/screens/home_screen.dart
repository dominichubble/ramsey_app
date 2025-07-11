import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/home_events.dart';
import '../widgets/home_food_and_drink.dart';
import '../widgets/home_highlights.dart';
import '../widgets/home_news.dart';

class HomeScreen extends StatelessWidget {
  final Function(int)? onNavigateToTab;

  const HomeScreen({super.key, this.onNavigateToTab});

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeNews(),
            const HomeHighlights(),
            HomeEvents(onNavigateToTab: onNavigateToTab),
            const HomeFoodAndDrink(),
          ],
        ),
      ),
    );
  }
}
