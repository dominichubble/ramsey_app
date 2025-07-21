import 'package:flutter/material.dart';
import '../models/news.dart';
import '../services/news_service.dart';
import '../widgets/news_card.dart';
import '../widgets/custom_app_bar.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsService _newsService = NewsService();
  NewsCategory? _selectedCategory;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<News> get filteredNews {
    List<News> news = List.from(_newsService.getAllNews());

    // Apply category filter
    if (_selectedCategory != null) {
      news = news.where((item) => item.category == _selectedCategory).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      news = _newsService.searchNews(_searchQuery);
    }

    // Sort by date (newest first)
    news.sort((a, b) => b.publishedDate.compareTo(a.publishedDate));
    return news;
  }

  @override
  Widget build(BuildContext context) {
    final filteredNewsList = filteredNews;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'News',
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search news...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Category filter chips
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                // All categories chip
                Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: const Text('All'),
                    selected: _selectedCategory == null,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = null;
                      });
                    },
                    backgroundColor: Colors.grey[200],
                    selectedColor: Theme.of(context).primaryColor,
                    labelStyle: TextStyle(
                      color: _selectedCategory == null
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      fontWeight: _selectedCategory == null
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
                // Category chips
                ...NewsCategory.values.map((category) {
                  final isSelected = _selectedCategory == category;
                  return Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(category.displayName),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = selected ? category : null;
                        });
                      },
                      backgroundColor: Colors.grey[200],
                      selectedColor: category.color,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : category.color,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Results count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  '${filteredNewsList.length} articles found',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // News list
          Expanded(
            child: filteredNewsList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.article_outlined,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No news articles found',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your search or filters',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    itemCount: filteredNewsList.length,
                    itemBuilder: (context, index) {
                      final news = filteredNewsList[index];
                      return SizedBox(
                        width: double.infinity,
                        child: NewsCard.fromNews(news),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
