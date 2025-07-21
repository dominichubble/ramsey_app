import 'package:flutter/material.dart';
import 'package:ramsey_app/widgets/custom_app_bar.dart';
import '../widgets/page_header.dart';
import '../widgets/find_events.dart';

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
