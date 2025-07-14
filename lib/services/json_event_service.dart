import '../models/event.dart';
import 'data_service.dart';

/// Example service showing how to integrate JSON data loading
/// This can replace or supplement the existing EventService
class JsonEventService {
  static final JsonEventService _instance = JsonEventService._internal();
  factory JsonEventService() => _instance;
  JsonEventService._internal();

  final DataService _dataService = DataService();
  List<Event>? _cachedEvents;

  /// Get all events (loads from JSON if not cached)
  Future<List<Event>> getAllEvents() async {
    _cachedEvents ??= await _dataService.getEventsFromJson();
    return List.unmodifiable(_cachedEvents!);
  }

  /// Get events for this week
  Future<List<Event>> getThisWeekEvents() async {
    final events = await getAllEvents();
    return events.where((event) => event.isThisWeek).toList();
  }

  /// Get events for next week
  Future<List<Event>> getNextWeekEvents() async {
    final events = await getAllEvents();
    return events.where((event) => event.isNextWeek).toList();
  }

  /// Get events for this month
  Future<List<Event>> getThisMonthEvents() async {
    final events = await getAllEvents();
    return events.where((event) => event.isThisMonth).toList();
  }

  /// Get events for next month
  Future<List<Event>> getNextMonthEvents() async {
    final events = await getAllEvents();
    return events.where((event) => event.isNextMonth).toList();
  }

  /// Get upcoming events (future events only)
  Future<List<Event>> getUpcomingEvents() async {
    final events = await getAllEvents();
    final now = DateTime.now();
    return events.where((event) => event.date.isAfter(now)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  /// Get featured/main event (next upcoming event)
  Future<Event?> getMainEvent() async {
    final upcoming = await getUpcomingEvents();
    return upcoming.isNotEmpty ? upcoming.first : null;
  }

  /// Get events by type
  Future<List<Event>> getEventsByType(EventType type) async {
    final events = await getAllEvents();
    return events.where((event) => event.type == type).toList();
  }

  /// Get events by status
  Future<List<Event>> getEventsByStatus(EventStatus status) async {
    final events = await getAllEvents();
    return events.where((event) => event.status == status).toList();
  }

  /// Get event by ID
  Future<Event?> getEventById(String id) async {
    final events = await getAllEvents();
    try {
      return events.firstWhere((event) => event.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Search events
  Future<List<Event>> searchEvents(String query) async {
    final events = await getAllEvents();
    final lowercaseQuery = query.toLowerCase();
    return events.where((event) {
      return event.title.toLowerCase().contains(lowercaseQuery) ||
          event.description.toLowerCase().contains(lowercaseQuery) ||
          event.location?.toLowerCase().contains(lowercaseQuery) == true;
    }).toList();
  }

  /// Add event (updates in-memory cache, would need to save to persistent storage)
  Future<void> addEvent(Event event) async {
    _cachedEvents ??= await getAllEvents();
    _cachedEvents!.add(event);
  }

  /// Update event (updates in-memory cache, would need to save to persistent storage)
  Future<void> updateEvent(Event updatedEvent) async {
    _cachedEvents ??= await getAllEvents();
    final index = _cachedEvents!.indexWhere(
      (event) => event.id == updatedEvent.id,
    );
    if (index != -1) {
      _cachedEvents![index] = updatedEvent;
    }
  }

  /// Delete event (updates in-memory cache, would need to save to persistent storage)
  Future<void> deleteEvent(String id) async {
    _cachedEvents ??= await getAllEvents();
    _cachedEvents!.removeWhere((event) => event.id == id);
  }

  /// Convert events to format expected by existing widgets
  Future<List<Map<String, dynamic>>> getEventsAsMap() async {
    final events = await getAllEvents();
    return events.map((event) => event.toMap()).toList();
  }

  /// Refresh data from JSON (clears cache and reloads)
  Future<void> refreshData() async {
    _dataService.clearCache();
    _cachedEvents = null;
    await getAllEvents(); // Reload data
  }
}
