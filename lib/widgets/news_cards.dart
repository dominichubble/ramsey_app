import 'package:flutter/material.dart';
import 'package:ramsey_app/widgets/news_card.dart';

// PageView carousel implementation for news cards
class NewsCards extends StatelessWidget {
  final List<Map<String, String>> newsItems;

  const NewsCards({super.key, required this.newsItems});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(
        viewportFraction: 0.85, // Shows a bit of the next card
      ),
      itemCount: newsItems.length,
      itemBuilder: (context, index) {
        final newsItem = newsItems[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: NewsCard(
            title: newsItem['title'] ?? '',
            description: newsItem['description'] ?? '',
            imageUrl: newsItem['imageUrl'] ?? '',
          ),
        );
      },
    );
  }
}
