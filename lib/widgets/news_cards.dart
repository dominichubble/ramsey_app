import 'package:flutter/material.dart';
import 'package:ramsey_app/widgets/news_card.dart';

class NewsCards extends StatelessWidget {
  final List<Map<String, String>> newsItems;

  const NewsCards({super.key, required this.newsItems});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal, // Make it horizontal
      itemCount: newsItems.length,
      itemBuilder: (context, index) {
        final newsItem = newsItems[index];
        return SizedBox(
          width: 280, // Fixed width for each card
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
