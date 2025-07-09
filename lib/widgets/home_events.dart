import 'package:flutter/material.dart';

import '../services/event_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/home_events_calendar.dart';
import '../widgets/home_main_event.dart';

class HomeEvents extends StatelessWidget {
  const HomeEvents({super.key});

  @override
  Widget build(BuildContext context) {
    final eventService = EventService();
    final mainEvent = eventService.getMainEvent();
    final eventsAsMap = eventService.getEventsAsMap();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and "See All" button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Events',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                CustomButton(
                  text: 'See All',
                  onPressed: () {
                    // TODO: Navigate to events page
                    print('Navigate to all events');
                  },
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  width: 100,
                ),
              ],
            ),
          ),

          // Main featured event
          if (mainEvent != null)
            MainEvent(
              title: mainEvent.title,
              date: mainEvent.formattedDate,
              imageUrl:
                  mainEvent.imageUrl ??
                  'https://picsum.photos/400/200?random=1',
            )
          else
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(child: Text('No upcoming events')),
            ),

          const SizedBox(height: 16),

          // Events calendar with filtering
          EventsCalendar(events: eventsAsMap),

          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
