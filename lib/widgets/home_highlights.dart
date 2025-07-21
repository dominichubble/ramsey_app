import 'package:flutter/material.dart';
import 'package:ramsey_app/widgets/home_highlight.dart';

import '../services/news_service.dart';
import 'custom_button.dart';

class HomeHighlights extends StatelessWidget {
  const HomeHighlights({super.key});

  @override
  Widget build(BuildContext context) {
    final newsService = NewsService();
    final featuredNews = newsService.getFeaturedNews();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Highlights',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              CustomButton(
                text: 'See All',
                onPressed: () {
                  // Handle see all action
                },
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                width: 100,
              ),
            ],
          ),
        ),
        // Generate highlights from featured news
        ...featuredNews.take(3).map((news) => HomeHighlight.fromNews(news)),
      ],
    );
  }
}
