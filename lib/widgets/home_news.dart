import 'package:flutter/material.dart';
import 'package:ramsey_app/widgets/news_cards.dart';
import '../services/news_service.dart';
import '../widgets/custom_button.dart';

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Latest News',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              CustomButton(
                text: 'See All',
                onPressed: () {
                  Navigator.pushNamed(context, '/news');
                },
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                width: 100,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300, // Fixed height for the ListView
          child: NewsCards(newsItems: latestNews),
        ),
      ],
    );
  }
}
