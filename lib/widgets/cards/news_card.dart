import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/news.dart';
import '../../screens/news/news_article_screen.dart';

// Enhanced news card that works with both Map and News model
class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String? author;
  final String? timeAgo;
  final String? category;
  final String? readTime;
  final bool? isFeatured;
  final News? newsModel; // Add the full news model for navigation
  final VoidCallback? onTap;

  const NewsCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.author,
    this.timeAgo,
    this.category,
    this.readTime,
    this.isFeatured,
    this.newsModel,
    this.onTap,
  });

  // Constructor from News model
  factory NewsCard.fromNews(News news) {
    return NewsCard(
      imageUrl: news.imageUrl ?? '',
      title: news.title,
      description: news.description,
      author: news.author,
      timeAgo: news.formattedDate,
      category: news.category.displayName,
      readTime: '${news.readTimeMinutes} min read',
      isFeatured: news.isFeatured,
      newsModel: news, // Pass the full model for navigation
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      elevation: 0,
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
        borderRadius: BorderRadius.circular(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with featured badge
            Stack(
              children: [
                // Main image container
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4),
                    ),
                    child: imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                if (kDebugMode) {
                                  print(
                                    '✅ Image loaded successfully: $imageUrl',
                                  );
                                }
                                return child;
                              }
                              return Container(
                                color: Colors.grey[300],
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        value:
                                            loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                            : null,
                                        strokeWidth: 2,
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Loading...',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              if (kDebugMode) {
                                print('❌ Error loading image: $imageUrl');
                                print('Error: $error');
                              }
                              return Container(
                                color: Colors.grey[200],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.article_outlined,
                                      size: 40,
                                      color: Theme.of(
                                        context,
                                      ).primaryColor.withValues(alpha: 0.6),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      category ?? 'News',
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).primaryColor.withValues(alpha: 0.8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : Container(
                            color: Colors.grey[200],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.article_outlined,
                                  size: 40,
                                  color: Theme.of(
                                    context,
                                  ).primaryColor.withValues(alpha: 0.6),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category ?? 'News',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).primaryColor.withValues(alpha: 0.8),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                // Featured badge
                if (isFeatured == true)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Featured',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                // Category badge
                if (category != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        category!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Content section
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // Footer with author, time, and read time
                  Row(
                    children: [
                      // Author and time
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (author != null)
                              Text(
                                author!,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            if (timeAgo != null)
                              Text(
                                timeAgo!,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: Colors.grey[600]),
                              ),
                          ],
                        ),
                      ),
                      // Read time
                      if (readTime != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            readTime!,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
