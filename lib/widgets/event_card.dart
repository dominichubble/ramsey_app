import 'package:flutter/material.dart';

// Reusable event card widget with image-focused layout
class EventCard extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[300]!, width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Event image covering the top of the card
          Container(
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12.0),
              ),
              color: Colors.grey[300],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12.0),
              ),
              child: event['imageUrl'] != null && event['imageUrl'].isNotEmpty
                  ? Image.network(
                      event['imageUrl'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.image,
                            color: Colors.grey[400],
                            size: 24,
                          ),
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.event,
                        color: Colors.grey[400],
                        size: 24,
                      ),
                    ),
            ),
          ),
          // Content section with padding
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date first
                Text(
                  _formatDate(event['date']),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                // Title below date
                Text(
                  event['title'] ?? 'Event',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
