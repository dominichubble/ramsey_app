import 'package:flutter/material.dart';
import '../cards/news_card.dart';
import '../../services/news_service.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final newsService = NewsService();
    final latestNews = newsService.getLatestNews(limit: 6);

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
          height: 340, // Fixed height for the PageView + indicators
          child: PageView.builder(
            itemCount: latestNews.length,
            itemBuilder: (context, index) {
              final news = latestNews[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: NewsCard.fromNews(news),
              );
            },
          ),
        ),
      ],
    );
  }
}
