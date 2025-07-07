import 'package:flutter/material.dart';
import '../widgets/home_main_event.dart';

class HomeEvents extends StatelessWidget {
  const HomeEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Events', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 8.0),
          // Placeholder for event items
          MainEvent(
            title: 'Upcoming Event Title',
            date: 'Dec 15, 2024',
            imageUrl: 'https://picsum.photos/400/200?random=1',
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5, // Example count
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Event ${index + 1}'),
                subtitle: Text('Event details here'),
              );
            },
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Handle see all action
            },
            child: const Text('See All'),
          ),
        ],
      ),
    );
  }
}
