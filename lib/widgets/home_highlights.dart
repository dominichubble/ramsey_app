import 'package:flutter/material.dart';
import 'package:ramsey_app/widgets/home_highlight.dart';
import 'custom_button.dart';

class HomeHighlights extends StatelessWidget {
  const HomeHighlights({super.key});

  @override
  Widget build(BuildContext context) {
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
        const HomeHighlight(
          author: 'Dave Ramsey',
          title: 'Building Wealth: The Key Steps to Financial Freedom',
          timePosted: '2 hours ago',
          imageUrl: 'https://via.placeholder.com/150x150',
        ),
        const HomeHighlight(
          author: 'Jane Doe',
          title: 'Investing 101: A Beginner\'s Guide',
          timePosted: '5 hours ago',
          imageUrl: 'https://via.placeholder.com/150x150',
        ),
        const HomeHighlight(
          author: 'John Smith',
          title: 'Retirement Planning: What You Need to Know',
          timePosted: '1 day ago',
          imageUrl: 'https://via.placeholder.com/150x150',
        ),
      ],
    );
  }
}
