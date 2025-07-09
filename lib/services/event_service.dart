import '../models/event.dart';

class EventService {
  static final EventService _instance = EventService._internal();
  factory EventService() => _instance;
  EventService._internal();

  // Sample events data for Ramsey, Isle of Man
  static final List<Event> _events = [
    Event(
      id: '1',
      title: 'Ramsey Summer Festival',
      description:
          'Annual summer festival featuring live music, local food vendors, and family activities on the promenade.',
      date: DateTime(2025, 7, 12, 11, 0), // Jul 12, 2025 11:00 AM
      imageUrl:
          'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=400&h=200&fit=crop',
      location: 'Ramsey Promenade',
      type: EventType.conference, // Festival
    ),
    Event(
      id: '2',
      title: 'Mooragh Park Fun Run',
      description:
          'Community 5K run around the beautiful Mooragh Park lake. All ages and abilities welcome.',
      date: DateTime(2025, 7, 15, 9, 0), // Jul 15, 2025 9:00 AM
      imageUrl:
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=200&fit=crop',
      location: 'Mooragh Park',
      type: EventType.workshop, // Sports Event
    ),
    Event(
      id: '3',
      title: 'Ramsey Heritage Walking Tour',
      description:
          'Discover the rich history of Ramsey with guided tours of historic buildings and landmarks.',
      date: DateTime(2025, 7, 18, 14, 0), // Jul 18, 2025 2:00 PM
      imageUrl:
          'https://images.unsplash.com/photo-1467103956184-29135c4bf58e?w=400&h=200&fit=crop',
      location: 'Ramsey Town Centre',
      type: EventType.seminar, // Educational Tour
    ),
    Event(
      id: '4',
      title: 'Farmers Market Weekend Special',
      description:
          'Extended weekend market with additional stalls, live music, and children\'s activities.',
      date: DateTime(2025, 7, 19, 9, 0), // Jul 19, 2025 9:00 AM
      imageUrl:
          'https://images.unsplash.com/photo-1488459716781-31db52582fe9?w=400&h=200&fit=crop',
      location: 'Parliament Square',
      type: EventType.meeting, // Market Event
    ),
    Event(
      id: '5',
      title: 'Ramsey Bay Sailing Regatta',
      description:
          'Annual sailing competition in Ramsey Bay featuring local and visiting yacht clubs.',
      date: DateTime(2025, 8, 2, 10, 0), // Aug 2, 2025 10:00 AM
      imageUrl:
          'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400&h=200&fit=crop',
      location: 'Ramsey Bay',
      type: EventType.conference, // Sports Event
    ),
    Event(
      id: '6',
      title: 'Manx Traditional Music Evening',
      description:
          'Enjoy traditional Isle of Man folk music and dancing at the Albert Hotel.',
      date: DateTime(2025, 8, 9, 19, 30), // Aug 9, 2025 7:30 PM
      imageUrl:
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&h=200&fit=crop',
      location: 'The Albert Hotel',
      type: EventType.seminar, // Cultural Event
    ),
    Event(
      id: '7',
      title: 'Ramsey Beach Clean-up Day',
      description:
          'Community volunteer event to keep our beautiful coastline clean and protect marine life.',
      date: DateTime(2025, 8, 16, 10, 0), // Aug 16, 2025 10:00 AM
      imageUrl:
          'https://images.unsplash.com/photo-1583212292454-1fe6229603b7?w=400&h=200&fit=crop',
      location: 'Ramsey Beach',
      type: EventType.workshop, // Community Service
    ),
    Event(
      id: '8',
      title: 'Northern Cricket Club Championship',
      description:
          'Local cricket championship at the Ramsey Cricket Club grounds.',
      date: DateTime(2025, 8, 23, 13, 0), // Aug 23, 2025 1:00 PM
      imageUrl:
          'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&h=200&fit=crop',
      location: 'Ramsey Cricket Club',
      type: EventType.meeting, // Sports Event
    ),
    Event(
      id: '9',
      title: 'Autumn Harvest Festival',
      description:
          'Celebrate the autumn harvest with local produce, crafts, and traditional Manx foods.',
      date: DateTime(2025, 9, 14, 11, 0), // Sep 14, 2025 11:00 AM
      imageUrl:
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=200&fit=crop',
      location: 'Mooragh Park',
      type: EventType.conference, // Festival
    ),
    Event(
      id: '10',
      title: 'Ramsey Photography Exhibition',
      description:
          'Local photographers showcase the beauty of Ramsey and the Isle of Man.',
      date: DateTime(2025, 9, 20, 18, 0), // Sep 20, 2025 6:00 PM
      imageUrl:
          'https://images.unsplash.com/photo-1452421822248-d4c2b47f08be?w=400&h=200&fit=crop',
      location: 'Ramsey Library',
      type: EventType.seminar, // Art Exhibition
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
