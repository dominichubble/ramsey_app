import 'package:flutter/material.dart';
import '../services/event_service.dart';

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
        print('Error parsing date: $dateString - $e');
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
        Container(
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
          height: 110, // Reduced from 120 to 110
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
                    return Container(
                      width: 280,
                      margin: const EdgeInsets.only(right: 12.0),
                      padding: const EdgeInsets.all(
                        12.0,
                      ), // Reduced from 16 to 12
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize:
                            MainAxisSize.min, // Added to minimize height
                        children: [
                          // Event image at the top
                          Container(
                            height: 40, // Reduced from 45 to 40
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.grey[300],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child:
                                  event['imageUrl'] != null &&
                                      event['imageUrl'].isNotEmpty
                                  ? Image.network(
                                      event['imageUrl'],
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.white.withOpacity(
                                                0.2,
                                              ),
                                              child: Icon(
                                                Icons.image,
                                                color: Colors.white.withOpacity(
                                                  0.7,
                                                ),
                                                size:
                                                    24, // Reduced from 30 to 24
                                              ),
                                            );
                                          },
                                    )
                                  : Container(
                                      color: Colors.white.withOpacity(0.2),
                                      child: Icon(
                                        Icons.event,
                                        color: Colors.white.withOpacity(0.7),
                                        size: 24, // Reduced from 30 to 24
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 6), // Reduced from 8 to 6
                          Text(
                            event['title'] ?? 'Event',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13, // Reduced from 14 to 13
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2), // Reduced from 4 to 2
                          Text(
                            _formatDate(event['date']),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 11, // Reduced from 12 to 11
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (event['description'] != null) ...[
                            const SizedBox(height: 2), // Reduced from 4 to 2
                            Flexible(
                              child: Text(
                                event['description'],
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 9, // Reduced from 10 to 9
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  String _formatDate(String dateString) {
    final parsedDate = _parseEventDate(dateString);
    if (parsedDate == null) {
      // If we can't parse it, return the original string
      return dateString;
    }

    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[parsedDate.month - 1]} ${parsedDate.day}, ${parsedDate.year}';
  }
}
