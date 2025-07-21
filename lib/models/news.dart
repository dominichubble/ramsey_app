import 'package:flutter/material.dart';

class News {
  final String id;
  final String title;
  final String description;
  final String content;
  final DateTime publishedDate;
  final String? imageUrl;
  final String? author;
  final NewsCategory category;
  final List<String> tags;
  final bool isFeatured;
  final int readTimeMinutes;

  News({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.publishedDate,
    this.imageUrl,
    this.author,
    required this.category,
    this.tags = const [],
    this.isFeatured = false,
    required this.readTimeMinutes,
  });

  // Helper methods for date formatting
  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(publishedDate);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} minutes ago';
      }
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return '1 day ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? '1 year ago' : '$years years ago';
    }
  }

  String get shortFormattedDate {
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
    return '${months[publishedDate.month - 1]} ${publishedDate.day}, ${publishedDate.year}';
  }

  // Helper methods for time-based filtering
  bool get isToday {
    final now = DateTime.now();
    return publishedDate.year == now.year &&
        publishedDate.month == now.month &&
        publishedDate.day == now.day;
  }

  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return publishedDate.isAfter(
          startOfWeek.subtract(const Duration(days: 1)),
        ) &&
        publishedDate.isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  bool get isThisMonth {
    final now = DateTime.now();
    return publishedDate.year == now.year && publishedDate.month == now.month;
  }

  // JSON serialization (for future API integration)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'publishedDate': publishedDate.toIso8601String(),
      'imageUrl': imageUrl,
      'author': author,
      'category': category.toString(),
      'tags': tags,
      'isFeatured': isFeatured,
      'readTimeMinutes': readTimeMinutes,
    };
  }

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      content: json['content'],
      publishedDate: DateTime.parse(json['publishedDate']),
      imageUrl: json['imageUrl'],
      author: json['author'],
      category: NewsCategoryExtension.fromString(json['category']),
      tags: List<String>.from(json['tags'] ?? []),
      isFeatured: json['isFeatured'] ?? false,
      readTimeMinutes: json['readTimeMinutes'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is News && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

enum NewsCategory {
  townCouncil,
  community,
  events,
  development,
  transport,
  environment,
  heritage,
  sports,
  education,
  business,
  general,
}

// Extension to get display names and colors
extension NewsCategoryExtension on NewsCategory {
  String get displayName {
    switch (this) {
      case NewsCategory.townCouncil:
        return 'Town Council';
      case NewsCategory.community:
        return 'Community';
      case NewsCategory.events:
        return 'Events';
      case NewsCategory.development:
        return 'Development';
      case NewsCategory.transport:
        return 'Transport';
      case NewsCategory.environment:
        return 'Environment';
      case NewsCategory.heritage:
        return 'Heritage';
      case NewsCategory.sports:
        return 'Sports';
      case NewsCategory.education:
        return 'Education';
      case NewsCategory.business:
        return 'Business';
      case NewsCategory.general:
        return 'General';
    }
  }

  Color get color {
    switch (this) {
      case NewsCategory.townCouncil:
        return Colors.blue;
      case NewsCategory.community:
        return Colors.orange;
      case NewsCategory.events:
        return Colors.purple;
      case NewsCategory.development:
        return Colors.indigo;
      case NewsCategory.transport:
        return Colors.green;
      case NewsCategory.environment:
        return Colors.teal;
      case NewsCategory.heritage:
        return Colors.brown;
      case NewsCategory.sports:
        return Colors.red;
      case NewsCategory.education:
        return Colors.cyan;
      case NewsCategory.business:
        return Colors.amber;
      case NewsCategory.general:
        return Colors.grey;
    }
  }

  static NewsCategory fromString(String category) {
    return NewsCategory.values.firstWhere(
      (e) => e.toString() == category,
      orElse: () => NewsCategory.general,
    );
  }
}
