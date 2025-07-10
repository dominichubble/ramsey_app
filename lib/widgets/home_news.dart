import 'package:flutter/material.dart';
import 'package:ramsey_app/widgets/news_cards.dart';

import '../services/news_service.dart';

class HomeNews extends StatelessWidget {
  const HomeNews({super.key});

  @override
  Widget build(BuildContext context) {
    final newsService = NewsService();
    final latestNews = newsService.getLatestNewsAsStringMap(limit: 6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                Icons.article_outlined,
                size: 28,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                'Latest News',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300, // Fixed height for the PageView
          child: NewsCards(newsItems: latestNews),
        ),
      ],
    );
  }
}
