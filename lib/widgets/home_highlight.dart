import 'package:flutter/material.dart';
import '../models/news.dart';
import '../screens/news_article_screen.dart';

class HomeHighlight extends StatelessWidget {
  final String? author;
  final String? title;
  final String? timePosted;
  final String? imageUrl;
  final News? newsModel; // Add the full news model for navigation
  final VoidCallback? onTap;

  const HomeHighlight({
    super.key,
    this.author,
    this.title,
    this.timePosted,
    this.imageUrl,
    this.newsModel,
    this.onTap,
  });

  // Constructor from News model
  factory HomeHighlight.fromNews(News news) {
    return HomeHighlight(
      author: news.author,
      title: news.title,
      timePosted: news.formattedDate,
      imageUrl: news.imageUrl,
      newsModel: news, // Pass the full model for navigation
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap!();
          } else if (newsModel != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsArticleScreen(article: newsModel!),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Left side - Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Author
                    Text(
                      author ?? 'Unknown Author',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Title
                    Text(
                      title ?? 'Highlight Title',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Time posted
                    Text(
                      timePosted ?? '2 hours ago',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Right side - Square image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[300],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: imageUrl != null && imageUrl!.isNotEmpty
                      ? Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.image,
                                color: Colors.grey,
                                size: 30,
                              ),
                            );
                          },
                        )
                      : Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
