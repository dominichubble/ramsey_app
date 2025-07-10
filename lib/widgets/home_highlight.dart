import 'package:flutter/material.dart';

class HomeHighlight extends StatelessWidget {
  final String? author;
  final String? title;
  final String? timePosted;
  final String? imageUrl;

  const HomeHighlight({
    super.key,
    this.author,
    this.title,
    this.timePosted,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          // Left side - Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Author
                Text(
                  author ?? 'Unknown Author',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                // Title
                Text(
                  title ?? 'Highlight Title',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Time posted
                Text(
                  timePosted ?? '2 hours ago',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Right side - Square image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey[300],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: 30,
                          ),
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.image,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
