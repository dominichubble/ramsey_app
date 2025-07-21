import 'package:flutter/material.dart';

import '../../services/event_service.dart';
import '../cards/event_card.dart';

enum EventFilter { thisWeek, nextWeek, thisMonth, nextMonth }

class EventsCalendar extends StatefulWidget {
  final List<Map<String, dynamic>>? events; // Made optional

  const EventsCalendar({super.key, this.events});

  @override
  State<EventsCalendar> createState() => _EventsCalendarState();
}

class _EventsCalendarState extends State<EventsCalendar> {
  EventFilter selectedFilter = EventFilter.thisWeek;
  final EventService _eventService = EventService();

  List<Map<String, dynamic>> getFilteredEvents() {
    // Use EventService data if no events provided, or if provided events lack imageUrl
    final events = widget.events ?? _eventService.getEventsAsMap();

    // Check if the provided events have imageUrl, if not, use EventService
    final useServiceEvents =
        events.isEmpty ||
        (events.isNotEmpty && !events.first.containsKey('imageUrl'));

    final eventsToFilter = useServiceEvents
        ? _eventService.getEventsAsMap()
        : events;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    switch (selectedFilter) {
      case EventFilter.thisWeek:
        final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
        final endOfWeek = startOfWeek.add(const Duration(days: 6));
        return eventsToFilter.where((event) {
          final eventDate = _parseEventDate(event['date']);
          if (eventDate == null) return false;
          return eventDate.isAfter(
                startOfWeek.subtract(const Duration(days: 1)),
              ) &&
              eventDate.isBefore(endOfWeek.add(const Duration(days: 1)));
        }).toList();

      case EventFilter.nextWeek:
        final startOfNextWeek = today.add(
          Duration(days: 7 - today.weekday + 1),
        );
        final endOfNextWeek = startOfNextWeek.add(const Duration(days: 6));
        return eventsToFilter.where((event) {
          final eventDate = _parseEventDate(event['date']);
          if (eventDate == null) return false;
          return eventDate.isAfter(
                startOfNextWeek.subtract(const Duration(days: 1)),
              ) &&
              eventDate.isBefore(endOfNextWeek.add(const Duration(days: 1)));
        }).toList();

      case EventFilter.thisMonth:
        final startOfMonth = DateTime(now.year, now.month, 1);
        final endOfMonth = DateTime(now.year, now.month + 1, 0);
        return eventsToFilter.where((event) {
          final eventDate = _parseEventDate(event['date']);
          if (eventDate == null) return false;
          return eventDate.isAfter(
                startOfMonth.subtract(const Duration(days: 1)),
              ) &&
              eventDate.isBefore(endOfMonth.add(const Duration(days: 1)));
        }).toList();

      case EventFilter.nextMonth:
        final startOfNextMonth = DateTime(now.year, now.month + 1, 1);
        final endOfNextMonth = DateTime(now.year, now.month + 2, 0);
        return eventsToFilter.where((event) {
          final eventDate = _parseEventDate(event['date']);
          if (eventDate == null) return false;
          return eventDate.isAfter(
                startOfNextMonth.subtract(const Duration(days: 1)),
              ) &&
              eventDate.isBefore(endOfNextMonth.add(const Duration(days: 1)));
        }).toList();
    }
  }

  DateTime? _parseEventDate(String dateString) {
    try {
      // Try ISO format first (e.g., "2024-12-01")
      return DateTime.parse(dateString);
    } catch (e) {
      try {
        // Try to parse formatted date like "Dec 1, 2024"
        final months = {
          'Jan': 1,
          'Feb': 2,
          'Mar': 3,
          'Apr': 4,
          'May': 5,
          'Jun': 6,
          'Jul': 7,
          'Aug': 8,
          'Sep': 9,
          'Oct': 10,
          'Nov': 11,
          'Dec': 12,
        };

        final parts = dateString.split(' ');
        if (parts.length == 3) {
          final monthName = parts[0];
          final day = int.parse(parts[1].replaceAll(',', ''));
          final year = int.parse(parts[2]);
          final month = months[monthName];

          if (month != null) {
            return DateTime(year, month, day);
          }
        }
      } catch (e) {
        debugPrint('Error parsing date: $dateString - $e');
      }
      return null;
    }
  }

  String getFilterText(EventFilter filter) {
    switch (filter) {
      case EventFilter.thisWeek:
        return 'This Week';
      case EventFilter.nextWeek:
        return 'Next Week';
      case EventFilter.thisMonth:
        return 'This Month';
      case EventFilter.nextMonth:
        return 'Next Month';
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredEvents = getFilteredEvents();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filter buttons
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: EventFilter.values.map((filter) {
              final isSelected = selectedFilter == filter;
              return Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: FilterChip(
                  label: Text(
                    getFilterText(filter),
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                  backgroundColor: Colors.grey[200],
                  selectedColor: Theme.of(context).primaryColor,
                  checkmarkColor: Colors.white,
                  side: BorderSide(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey[400]!,
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 16),

        // Events horizontal scroll
        SizedBox(
          height: 170,
          child: filteredEvents.isEmpty
              ? Center(
                  child: Text(
                    'No events for ${getFilterText(selectedFilter).toLowerCase()}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: filteredEvents.length,
                  itemBuilder: (context, index) {
                    final event = filteredEvents[index];
                    return EventCard(event: event);
                  },
                ),
        ),
      ],
    );
  }
}
