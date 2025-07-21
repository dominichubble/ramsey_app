import 'package:flutter/material.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/page_header.dart';
import '../../widgets/sections/find_events.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Events',
        automaticallyImplyLeading: false,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            PageHeader(
              title: 'Upcoming Events',
              subtitle: 'Discover what\'s happening in Ramsey Town',
              icon: Icons.event,
            ),
            FindEvents(),
            // Add more widgets here
          ],
        ),
      ),
    );
  }
}
