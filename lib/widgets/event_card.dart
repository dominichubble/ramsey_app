import 'package:flutter/material.dart';

// Reusable event card widget for displaying event information
class EventCard extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Event image at the top
          Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey[300],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: event['imageUrl'] != null && event['imageUrl'].isNotEmpty
                  ? Image.network(
                      event['imageUrl'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.white.withValues(alpha: 0.2),
                          child: Icon(
                            Icons.image,
                            color: Colors.white.withValues(alpha: 0.7),
                            size: 24,
                          ),
                        );
                      },
                    )
                  : Container(
                      color: Colors.white.withValues(alpha: 0.2),
                      child: Icon(
                        Icons.event,
                        color: Colors.white.withValues(alpha: 0.7),
                        size: 24,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            event['title'] ?? 'Event',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            _formatDate(event['date']),
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (event['description'] != null) ...[
            const SizedBox(height: 2),
            Flexible(
              child: Text(
                event['description'],
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 9,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
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
