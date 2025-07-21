import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Map<String, String> information;
  final Color? color;

  const InfoCard({
    super.key,
    required this.title,
    required this.icon,
    required this.information,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? Theme.of(context).primaryColor;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: cardColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: cardColor, size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Information items
            ...information.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildInfoRow(context, entry.key, entry.value),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final isContactInfo =
        label.toLowerCase().contains('email') ||
        label.toLowerCase().contains('phone');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            _formatLabel(label),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: isContactInfo
                ? () => _copyToClipboard(context, value)
                : null,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: isContactInfo
                    ? Theme.of(context).primaryColor
                    : Colors.black87,
                decoration: isContactInfo ? TextDecoration.underline : null,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatLabel(String label) {
    return label
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied to clipboard: $text'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
