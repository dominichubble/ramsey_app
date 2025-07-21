import 'package:flutter/material.dart';

import '../../models/event.dart';
import '../../services/event_service.dart';
import '../cards/event_card.dart';

class FindEvents extends StatefulWidget {
  const FindEvents({super.key});

  @override
  State<FindEvents> createState() => _FindEventsState();
}

class _FindEventsState extends State<FindEvents> {
  final EventService _eventService = EventService();
  final TextEditingController _searchController = TextEditingController();

  List<Event> _allEvents = [];
  List<Event> _filteredEvents = [];
  bool _hasSearched = false;
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadEvents() {
    _allEvents = _eventService.getAllEvents();
  }

  void _searchEvents() {
    setState(() {
      _hasSearched = true;

      if (_searchController.text.isEmpty && _selectedDateRange == null) {
        _filteredEvents = _allEvents;
      } else {
        _filteredEvents = _allEvents.where((event) {
          // Text search filter
          bool matchesText = true;
          if (_searchController.text.isNotEmpty) {
            final searchQuery = _searchController.text.toLowerCase();
            final eventTitle = event.title.toLowerCase();
            final eventLocation = (event.location ?? '').toLowerCase();
            final eventDescription = event.description.toLowerCase();

            matchesText =
                eventTitle.contains(searchQuery) ||
                eventLocation.contains(searchQuery) ||
                eventDescription.contains(searchQuery);
          }

          // Date range filter
          bool matchesDate = true;
          if (_selectedDateRange != null) {
            final eventDate = DateTime(
              event.date.year,
              event.date.month,
              event.date.day,
            );
            final startDate = DateTime(
              _selectedDateRange!.start.year,
              _selectedDateRange!.start.month,
              _selectedDateRange!.start.day,
            );
            final endDate = DateTime(
              _selectedDateRange!.end.year,
              _selectedDateRange!.end.month,
              _selectedDateRange!.end.day,
            );

            matchesDate =
                (eventDate.isAtSameMomentAs(startDate) ||
                    eventDate.isAfter(startDate)) &&
                (eventDate.isAtSameMomentAs(endDate) ||
                    eventDate.isBefore(endDate));
          }

          return matchesText && matchesDate;
        }).toList();
      }
    });
  }

  void _clearSelection() {
    setState(() {
      _searchController.clear();
      _selectedDateRange = null;
      _filteredEvents = [];
      _hasSearched = false;
    });
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: _selectedDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: Theme.of(context).primaryColor),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  String get _dateRangeText {
    if (_selectedDateRange == null) {
      return 'Select date range...';
    }
    final start = _selectedDateRange!.start;
    final end = _selectedDateRange!.end;
    return '${start.day}/${start.month}/${start.year} - ${end.day}/${end.month}/${end.year}';
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

                // Search TextField
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search events, locations, activities...',
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

                // Date Range Selector
                GestureDetector(
                  onTap: _selectDateRange,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _dateRangeText,
                            style: TextStyle(
                              color: _selectedDateRange == null
                                  ? Colors.grey[600]
                                  : Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (_selectedDateRange != null)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedDateRange = null;
                              });
                            },
                            child: Icon(
                              Icons.clear,
                              color: Colors.grey[600],
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Search Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _searchEvents,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 12.0,
                      ),
                    ),
                    child: Text('Search Events'),
                  ),
                ),

                const SizedBox(height: 12),

                // Clear Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _clearSelection,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 12.0,
                      ),
                    ),
                    child: Text('Clear Selection'),
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
