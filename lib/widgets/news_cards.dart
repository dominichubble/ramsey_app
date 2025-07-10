import 'package:flutter/material.dart';
import 'package:ramsey_app/widgets/news_card.dart';

// PageView carousel implementation for news cards with dot indicators
class NewsCards extends StatefulWidget {
  final List<Map<String, String>> newsItems;

  const NewsCards({super.key, required this.newsItems});

  @override
  State<NewsCards> createState() => _NewsCardsState();
}

class _NewsCardsState extends State<NewsCards> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.85, // Shows a bit of the next card
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // PageView carousel
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.newsItems.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final newsItem = widget.newsItems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: NewsCard(
                  title: newsItem['title'] ?? '',
                  description: newsItem['description'] ?? '',
                  imageUrl: newsItem['imageUrl'] ?? '',
                ),
              );
            },
          ),
        ),
        // Page indicators
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.newsItems.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                height: 8.0,
                width: _currentPage == index ? 24.0 : 8.0,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey[400],
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
