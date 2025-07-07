import 'package:flutter/material.dart';
import 'package:ramsey_app/widgets/news_cards.dart';

class HomeNews extends StatelessWidget {
  const HomeNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Latest News',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        SizedBox(
          height: 300, // Fixed height for the ListView
          child: NewsCards(
            newsItems: [
              {
                'title': 'Breaking News 1',
                'description': 'Description for breaking news 1',
                'imageUrl': 'https://picsum.photos/300/200?random=1',
              },
              {
                'title': 'Breaking News 2',
                'description': 'Description for breaking news 2',
                'imageUrl': 'https://picsum.photos/300/200?random=2',
              },
              {
                'title': 'Breaking News 3',
                'description': 'Description for breaking news 3',
                'imageUrl': 'https://picsum.photos/300/200?random=3',
              },
            ],
          ),
        ),
      ],
    );
  }
}
