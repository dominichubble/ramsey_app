import '../models/event.dart';

class EventService {
  static final EventService _instance = EventService._internal();
  factory EventService() => _instance;
  EventService._internal();

  // Sample events data
  static final List<Event> _events = [
    Event(
      id: '1',
      title: 'Financial Planning Workshop',
      description:
          'Learn essential budgeting and investment strategies for building long-term wealth.',
      date: DateTime(2025, 7, 10, 14, 0), // Jul 10, 2025 2:00 PM
      imageUrl: 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=400&h=200&fit=crop',
      location: 'Ramsey Solutions Office',
      type: EventType.workshop,
    ),
    Event(
      id: '2',
      title: 'Retirement Planning Seminar',
      description:
          'Discover how to plan for your golden years and retire with confidence.',
      date: DateTime(2025, 7, 15, 18, 30), // Jul 15, 2025 6:30 PM
      imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=200&fit=crop',
      location: 'Virtual Event',
      type: EventType.seminar,
    ),
    Event(
      id: '3',
      title: 'Investment Strategies Meeting',
      description:
          'Deep dive into modern investment approaches and portfolio management.',
      date: DateTime(2025, 7, 22, 10, 0), // Jul 22, 2025 10:00 AM
      imageUrl: null, // Test without image
      location: 'Downtown Conference Center',
      type: EventType.meeting,
    ),
    Event(
      id: '4',
      title: 'Tax Preparation Workshop',
      description: 'Get ready for tax season with expert tips and strategies.',
      date: DateTime(2025, 8, 5, 9, 0), // Aug 5, 2025 9:00 AM
      imageUrl: 'https://picsum.photos/400/200?random=4',
      location: 'Ramsey Solutions Office',
      type: EventType.workshop,
    ),
    Event(
      id: '5',
      title: 'Debt Freedom Conference',
      description:
          'Join thousands learning how to break free from debt once and for all.',
      date: DateTime(2025, 8, 15, 8, 0), // Aug 15, 2025 8:00 AM
      imageUrl: 'https://picsum.photos/400/200?random=5',
      location: 'Nashville Convention Center',
      type: EventType.conference,
    ),
    Event(
      id: '6',
      title: 'Emergency Fund Webinar',
      description: 'Learn how to build and maintain your emergency fund.',
      date: DateTime(2025, 8, 20, 19, 0), // Aug 20, 2025 7:00 PM
      imageUrl: 'https://picsum.photos/400/200?random=6',
      location: 'Online',
      type: EventType.webinar,
    ),
  ];

  // Get all events
  List<Event> getAllEvents() {
    return List.unmodifiable(_events);
  }

  // Get events for this week
  List<Event> getThisWeekEvents() {
    return _events.where((event) => event.isThisWeek).toList();
  }

  // Get events for next week
  List<Event> getNextWeekEvents() {
    return _events.where((event) => event.isNextWeek).toList();
  }

  // Get events for this month
  List<Event> getThisMonthEvents() {
    return _events.where((event) => event.isThisMonth).toList();
  }

  // Get events for next month
  List<Event> getNextMonthEvents() {
    return _events.where((event) => event.isNextMonth).toList();
  }

  // Get upcoming events (future events only)
  List<Event> getUpcomingEvents() {
    final now = DateTime.now();
    return _events.where((event) => event.date.isAfter(now)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  // Get featured/main event (next upcoming event)
  Event? getMainEvent() {
    final upcoming = getUpcomingEvents();
    return upcoming.isNotEmpty ? upcoming.first : null;
  }

  // Get events by type
  List<Event> getEventsByType(EventType type) {
    return _events.where((event) => event.type == type).toList();
  }

  // Get events by status
  List<Event> getEventsByStatus(EventStatus status) {
    return _events.where((event) => event.status == status).toList();
  }

  // Get event by ID
  Event? getEventById(String id) {
    try {
      return _events.firstWhere((event) => event.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search events
  List<Event> searchEvents(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _events.where((event) {
      return event.title.toLowerCase().contains(lowercaseQuery) ||
          event.description.toLowerCase().contains(lowercaseQuery) ||
          event.location?.toLowerCase().contains(lowercaseQuery) == true;
    }).toList();
  }

  // Add event (for future functionality)
  void addEvent(Event event) {
    _events.add(event);
  }

  // Update event (for future functionality)
  void updateEvent(Event updatedEvent) {
    final index = _events.indexWhere((event) => event.id == updatedEvent.id);
    if (index != -1) {
      _events[index] = updatedEvent;
    }
  }

  // Delete event (for future functionality)
  void deleteEvent(String id) {
    _events.removeWhere((event) => event.id == id);
  }

  // Convert events to format expected by existing widgets
  List<Map<String, dynamic>> getEventsAsMap() {
    return _events
        .map(
          (event) => {
            'id': event.id,
            'title': event.title,
            'description': event.description,
            'date':
                '${event.date.year}-${event.date.month.toString().padLeft(2, '0')}-${event.date.day.toString().padLeft(2, '0')}', // ISO format for filtering
            'imageUrl': event.imageUrl ?? '',
            'location': event.location ?? '',
            'type': event.type.toString(),
            'status': event.status.toString(),
          },
        )
        .toList();
  }
}
