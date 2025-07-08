import '../models/news.dart';

class NewsService {
  static final NewsService _instance = NewsService._internal();
  factory NewsService() => _instance;
  NewsService._internal();

  // Sample news data
  static final List<News> _news = [
    News(
      id: '1',
      title: 'Breaking: New Tax Strategies for 2025',
      description:
          'Discover the latest tax-saving strategies that could save you thousands this year.',
      content:
          'With the new tax year approaching, financial experts are highlighting several key strategies that could significantly impact your tax bill. From retirement contributions to strategic deductions, here\'s what you need to know...',
      publishedDate: DateTime.now().subtract(const Duration(hours: 2)),
      imageUrl: 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=400&h=200&fit=crop',
      author: 'Sarah Johnson',
      category: NewsCategory.taxes,
      tags: ['tax planning', 'savings', '2025'],
      isFeatured: true,
      readTimeMinutes: 5,
    ),
    News(
      id: '2',
      title: 'Investment Market Update: What to Watch',
      description:
          'Key market trends and investment opportunities for the current quarter.',
      content:
          'The investment landscape continues to evolve with new opportunities and challenges emerging across various sectors. Our analysis shows...',
      publishedDate: DateTime.now().subtract(const Duration(hours: 5)),
      imageUrl: 'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=400&h=200&fit=crop',
      author: 'Michael Chen',
      category: NewsCategory.investing,
      tags: ['market analysis', 'investing', 'trends'],
      isFeatured: false,
      readTimeMinutes: 7,
    ),
    News(
      id: '3',
      title: 'Emergency Fund Essentials: How Much is Enough?',
      description:
          'Financial experts weigh in on building the perfect emergency fund for your situation.',
      content:
          'Building an emergency fund is one of the most crucial steps in achieving financial security. But how much should you save?',
      publishedDate: DateTime.now().subtract(const Duration(days: 1)),
      imageUrl: null, // Test without image
      author: 'Lisa Rodriguez',
      category: NewsCategory.budgeting,
      tags: ['emergency fund', 'budgeting', 'savings'],
      isFeatured: true,
      readTimeMinutes: 4,
    ),
    News(
      id: '4',
      title: 'Debt Payoff Success Stories: Real People, Real Results',
      description:
          'Inspiring stories from individuals who successfully eliminated their debt using proven strategies.',
      content:
          'Meet three families who transformed their financial lives by following disciplined debt payoff strategies...',
      publishedDate: DateTime.now().subtract(const Duration(days: 2)),
      imageUrl: 'https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?w=400&h=200&fit=crop',
      author: 'David Thompson',
      category: NewsCategory.debt,
      tags: ['debt payoff', 'success stories', 'financial freedom'],
      isFeatured: false,
      readTimeMinutes: 6,
    ),
    News(
      id: '5',
      title: 'Retirement Planning in Your 30s: Start Now or Pay Later',
      description:
          'Why starting retirement planning early can make or break your financial future.',
      content:
          'The power of compound interest becomes most apparent when you start retirement planning in your 30s...',
      publishedDate: DateTime.now().subtract(const Duration(days: 3)),
      imageUrl: null, // Test without image
      author: 'Emily Parker',
      category: NewsCategory.retirement,
      tags: ['retirement', 'compound interest', 'financial planning'],
      isFeatured: false,
      readTimeMinutes: 8,
    ),
    News(
      id: '6',
      title: 'Real Estate Market Trends: Buy, Sell, or Wait?',
      description:
          'Current real estate market analysis and predictions for the coming months.',
      content:
          'The real estate market continues to show interesting patterns that both buyers and sellers should understand...',
      publishedDate: DateTime.now().subtract(const Duration(days: 5)),
      imageUrl: 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400&h=200&fit=crop',
      author: 'Robert Kim',
      category: NewsCategory.realEstate,
      tags: ['real estate', 'market trends', 'buying', 'selling'],
      isFeatured: false,
      readTimeMinutes: 10,
    ),
  ];

  // Get all news
  List<News> getAllNews() {
    return List.unmodifiable(_news);
  }

  // Get featured news
  List<News> getFeaturedNews() {
    return _news.where((news) => news.isFeatured).toList();
  }

  // Get latest news (most recent)
  List<News> getLatestNews({int limit = 10}) {
    final sortedNews = List<News>.from(_news)
      ..sort((a, b) => b.publishedDate.compareTo(a.publishedDate));
    return sortedNews.take(limit).toList();
  }

  // Get news by category
  List<News> getNewsByCategory(NewsCategory category) {
    return _news.where((news) => news.category == category).toList();
  }

  // Get today's news
  List<News> getTodaysNews() {
    return _news.where((news) => news.isToday).toList();
  }

  // Get this week's news
  List<News> getThisWeeksNews() {
    return _news.where((news) => news.isThisWeek).toList();
  }

  // Get this month's news
  List<News> getThisMonthsNews() {
    return _news.where((news) => news.isThisMonth).toList();
  }

  // Search news
  List<News> searchNews(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _news.where((news) {
      return news.title.toLowerCase().contains(lowercaseQuery) ||
          news.description.toLowerCase().contains(lowercaseQuery) ||
          news.content.toLowerCase().contains(lowercaseQuery) ||
          news.author?.toLowerCase().contains(lowercaseQuery) == true ||
          news.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  // Get news by ID
  News? getNewsById(String id) {
    try {
      return _news.firstWhere((news) => news.id == id);
    } catch (e) {
      return null;
    }
  }

  // Add news (for future functionality)
  void addNews(News news) {
    _news.add(news);
  }

  // Update news (for future functionality)
  void updateNews(News updatedNews) {
    final index = _news.indexWhere((news) => news.id == updatedNews.id);
    if (index != -1) {
      _news[index] = updatedNews;
    }
  }

  // Delete news (for future functionality)
  void deleteNews(String id) {
    _news.removeWhere((news) => news.id == id);
  }

  // Convert news to format expected by existing widgets
  List<Map<String, dynamic>> getNewsAsMap() {
    return _news
        .map(
          (news) => {
            'id': news.id,
            'title': news.title,
            'description': news.description,
            'imageUrl': news.imageUrl ?? '',
            'author': news.author ?? '',
            'publishedDate': news.shortFormattedDate,
            'timeAgo': news.formattedDate,
            'category': news.category.displayName,
            'readTime': '${news.readTimeMinutes} min read',
            'isFeatured': news.isFeatured,
          },
        )
        .toList();
  }

  // Get latest news as map format for backward compatibility
  List<Map<String, String>> getLatestNewsAsStringMap({int limit = 10}) {
    return getLatestNews(limit: limit)
        .map(
          (news) => {
            'title': news.title,
            'description': news.description,
            'imageUrl': news.imageUrl ?? '',
          },
        )
        .toList();
  }
}
