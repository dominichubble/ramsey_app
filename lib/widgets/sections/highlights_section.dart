import 'package:flutter/material.dart';
import '../cards/highlight_card.dart';
import '../../services/news_service.dart';
import '../common/custom_button.dart';

class HighlightsSection extends StatelessWidget {
  const HighlightsSection({super.key});

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
        ...featuredNews.take(3).map((news) => HighlightCard.fromNews(news)),
      ],
    );
  }
}
