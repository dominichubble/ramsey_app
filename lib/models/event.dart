import 'package:flutter/material.dart';

class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String? imageUrl;
  final String? location;
  final EventType type;
  final EventStatus status;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.imageUrl,
    this.location,
    this.type = EventType.workshop,
    this.status = EventStatus.upcoming,
  });

  // Create from JSON/Map
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] is String
          ? DateTime.parse(map['date'])
          : map['date'] as DateTime,
      imageUrl: map['imageUrl'],
      location: map['location'],
      type: EventType.values.firstWhere(
        (e) => e.toString() == 'EventType.${map['type']}',
        orElse: () => EventType.workshop,
      ),
      status: EventStatus.values.firstWhere(
        (e) => e.toString() == 'EventStatus.${map['status']}',
        orElse: () => EventStatus.upcoming,
      ),
    );
  }

  // Convert to JSON/Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'imageUrl': imageUrl,
      'location': location,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
    };
  }

  // Formatted date string
  String get formattedDate {
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
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  // Time until event
  Duration get timeUntil => date.difference(DateTime.now());

  // Is this week
  bool get isThisWeek {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    return date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
        date.isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  // Is next week
  bool get isNextWeek {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final startOfNextWeek = today.add(Duration(days: 7 - today.weekday + 1));
    final endOfNextWeek = startOfNextWeek.add(const Duration(days: 6));

    return date.isAfter(startOfNextWeek.subtract(const Duration(days: 1))) &&
        date.isBefore(endOfNextWeek.add(const Duration(days: 1)));
  }

  // Is this month
  bool get isThisMonth {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  // Is next month
  bool get isNextMonth {
    final now = DateTime.now();
    final nextMonth = DateTime(now.year, now.month + 1);
    return date.year == nextMonth.year && date.month == nextMonth.month;
  }

  // Copy with new values
  Event copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    String? imageUrl,
    String? location,
    EventType? type,
    EventStatus? status,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'Event(id: $id, title: $title, date: $formattedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Event && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

enum EventType { workshop, seminar, meeting, conference, webinar, consultation }

enum EventStatus { upcoming, ongoing, completed, cancelled }

// Extension to get display names
extension EventTypeExtension on EventType {
  String get displayName {
    switch (this) {
      case EventType.workshop:
        return 'Workshop';
      case EventType.seminar:
        return 'Seminar';
      case EventType.meeting:
        return 'Meeting';
      case EventType.conference:
        return 'Conference';
      case EventType.webinar:
        return 'Webinar';
      case EventType.consultation:
        return 'Consultation';
    }
  }

  Color get color {
    switch (this) {
      case EventType.workshop:
        return Colors.blue;
      case EventType.seminar:
        return Colors.green;
      case EventType.meeting:
        return Colors.orange;
      case EventType.conference:
        return Colors.purple;
      case EventType.webinar:
        return Colors.teal;
      case EventType.consultation:
        return Colors.red;
    }
  }

  IconData get icon {
    switch (this) {
      case EventType.workshop:
        return Icons.build;
      case EventType.seminar:
        return Icons.school;
      case EventType.meeting:
        return Icons.group;
      case EventType.conference:
        return Icons.event;
      case EventType.webinar:
        return Icons.videocam;
      case EventType.consultation:
        return Icons.person;
    }
  }
}

extension EventStatusExtension on EventStatus {
  String get displayName {
    switch (this) {
      case EventStatus.upcoming:
        return 'Upcoming';
      case EventStatus.ongoing:
        return 'Ongoing';
      case EventStatus.completed:
        return 'Completed';
      case EventStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get color {
    switch (this) {
      case EventStatus.upcoming:
        return Colors.blue;
      case EventStatus.ongoing:
        return Colors.green;
      case EventStatus.completed:
        return Colors.grey;
      case EventStatus.cancelled:
        return Colors.red;
    }
  }
}
