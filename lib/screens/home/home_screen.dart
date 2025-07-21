import 'package:flutter/material.dart';

import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/sections/events_section.dart';
import '../../widgets/sections/restaurants_section.dart';
import '../../widgets/sections/highlights_section.dart';
import '../../widgets/sections/news_section.dart';

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
            const NewsSection(),
            const HighlightsSection(),
            EventsSection(onNavigateToTab: onNavigateToTab),
            RestaurantsSection(onNavigateToTab: onNavigateToTab),
          ],
        ),
      ),
    );
  }
}
