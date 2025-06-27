import 'package:flutter/material.dart';
import 'package:ramsey_app/widgets/news_card.dart';

class NewsCards extends StatelessWidget {
  final List<Map<String, String>> newsItems;

  const NewsCards({super.key, required this.newsItems});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsItems.length,
      itemBuilder: (context, index) {
        final newsItem = newsItems[index];
        return NewsCard(
          title: newsItem['title'] ?? '',
          description: newsItem['description'] ?? '',
          imageUrl: newsItem['imageUrl'] ?? '',
        );
      },
    );
  }
}
