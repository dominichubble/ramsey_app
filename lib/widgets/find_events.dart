import 'package:flutter/material.dart';

import '../models/event.dart';
import '../services/event_service.dart';
import 'event_card.dart';

class FindEvents extends StatefulWidget {
  const FindEvents({super.key});

  @override
  State<FindEvents> createState() => _FindEventsState();
}

class _FindEventsState extends State<FindEvents> {
  final EventService _eventService = EventService();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  List<Event> _allEvents = [];
  List<Event> _filteredEvents = [];
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  void _loadEvents() {
    _allEvents = _eventService.getAllEvents();
  }

  void _searchEvents() {
    setState(() {
      _hasSearched = true;

      if (_fromController.text.isEmpty && _toController.text.isEmpty) {
        _filteredEvents = _allEvents;
      } else {
        _filteredEvents = _allEvents.where((event) {
          final eventTitle = event.title.toLowerCase();
          final eventLocation = (event.location ?? '').toLowerCase();
          final eventDescription = event.description.toLowerCase();

          final fromQuery = _fromController.text.toLowerCase();
          final toQuery = _toController.text.toLowerCase();

          bool matchesFrom =
              fromQuery.isEmpty ||
              eventTitle.contains(fromQuery) ||
              eventLocation.contains(fromQuery) ||
              eventDescription.contains(fromQuery);

          bool matchesTo =
              toQuery.isEmpty ||
              eventTitle.contains(toQuery) ||
              eventLocation.contains(toQuery) ||
              eventDescription.contains(toQuery);

          return matchesFrom && matchesTo;
        }).toList();
      }
    });
  }

  void _clearSelection() {
    setState(() {
      _fromController.clear();
      _toController.clear();
      _filteredEvents = [];
      _hasSearched = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Events', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 16),

          // Search Box Container
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What\'s On?',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),

                // From TextField
                TextField(
                  controller: _fromController,
                  decoration: InputDecoration(
                    hintText: 'Search events, locations...',
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),

                const SizedBox(height: 8),
                Divider(color: Colors.grey[300]),
                const SizedBox(height: 8),

                // To TextField
                TextField(
                  controller: _toController,
                  decoration: InputDecoration(
                    hintText: 'Additional search terms...',
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.filter_list,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Search Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _searchEvents,
                    child: Text('Search Events'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 12.0,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Clear Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _clearSelection,
                    child: Text('Clear Selection'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 12.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search Results
          if (_hasSearched) ...[
            const SizedBox(height: 24),

            // Results Header
            Row(
              children: [
                Icon(
                  Icons.event_outlined,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Search Results (${_filteredEvents.length})',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Results List
            if (_filteredEvents.isEmpty)
              Container(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Icon(Icons.search_off, size: 48, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No events found',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try different search terms or clear your selection to see all events',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              // Event Cards List
              Column(
                children: _filteredEvents.map((event) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: EventCard(event: event.toMap()),
                  );
                }).toList(),
              ),
          ],
        ],
      ),
    );
  }
}
