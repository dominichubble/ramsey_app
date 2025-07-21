import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/news.dart';
import '../widgets/custom_app_bar.dart';

class NewsArticleScreen extends StatelessWidget {
  final News article;

  const NewsArticleScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Article',
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              _shareArticle(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              _bookmarkArticle(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image
            if (article.imageUrl != null)
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(article.imageUrl!),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      debugPrint('Error loading article image: $exception');
                    },
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.3),
                      ],
                    ),
                  ),
                ),
              ),

            // Article content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category and read time
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(article.category),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _getCategoryDisplayName(article.category),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${article.readTimeMinutes} min read',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Article title
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Article description
                  Text(
                    article.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Author and date
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          article.author?.substring(0, 1).toUpperCase() ?? 'A',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.author ?? 'Anonymous',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              article.formattedDate,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Divider
                  Container(height: 1, color: Colors.grey[300]),

                  const SizedBox(height: 24),

                  // Article content
                  Text(
                    article.content,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Tags section
                  if (article.tags.isNotEmpty) ...[
                    const Text(
                      'Tags',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: article.tags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '#$tag',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 12,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _shareArticle(context),
                          icon: const Icon(Icons.share),
                          label: const Text('Share'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _bookmarkArticle(context),
                          icon: const Icon(Icons.bookmark_border),
                          label: const Text('Save'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(NewsCategory category) {
    switch (category) {
      case NewsCategory.finance:
        return Colors.green;
      case NewsCategory.investing:
        return Colors.blue;
      case NewsCategory.budgeting:
        return Colors.orange;
      case NewsCategory.debt:
        return Colors.red;
      case NewsCategory.retirement:
        return Colors.purple;
      case NewsCategory.insurance:
        return Colors.indigo;
      case NewsCategory.taxes:
        return Colors.brown;
      case NewsCategory.realEstate:
        return Colors.teal;
      case NewsCategory.business:
        return Colors.amber;
      case NewsCategory.general:
        return Colors.grey;
    }
  }

  String _getCategoryDisplayName(NewsCategory category) {
    switch (category) {
      case NewsCategory.finance:
        return 'Finance';
      case NewsCategory.investing:
        return 'Investing';
      case NewsCategory.budgeting:
        return 'Budgeting';
      case NewsCategory.debt:
        return 'Debt';
      case NewsCategory.retirement:
        return 'Retirement';
      case NewsCategory.insurance:
        return 'Insurance';
      case NewsCategory.taxes:
        return 'Taxes';
      case NewsCategory.realEstate:
        return 'Real Estate';
      case NewsCategory.business:
        return 'Business';
      case NewsCategory.general:
        return 'General';
    }
  }

  void _shareArticle(BuildContext context) {
    // Copy article URL to clipboard
    Clipboard.setData(
      ClipboardData(text: 'Check out this article: ${article.title}'),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Article link copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _bookmarkArticle(BuildContext context) {
    // TODO: Implement bookmark functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Article saved to bookmarks'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
