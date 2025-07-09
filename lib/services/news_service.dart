import '../models/news.dart';

class NewsService {
  static final NewsService _instance = NewsService._internal();
  factory NewsService() => _instance;
  NewsService._internal();

  // Sample news data for Ramsey, Isle of Man
  static final List<News> _news = [
    News(
      id: '1',
      title: 'Ramsey Harbour Regeneration Project Gets Green Light',
      description:
          'Major redevelopment of Ramsey Harbour will bring new shops, restaurants and visitor facilities.',
      content:
          'The long-awaited Ramsey Harbour regeneration project has received final approval from the Isle of Man Government. The £15 million development will transform the harbour area with new retail spaces, dining options, and improved facilities for both locals and tourists...',
      publishedDate: DateTime.now().subtract(const Duration(hours: 3)),
      imageUrl:
          'https://images.unsplash.com/photo-1544966503-7cc5ac882d5f?w=400&h=200&fit=crop',
      author: 'Emma Corlett',
      category: NewsCategory.realEstate,
      tags: ['harbour', 'development', 'tourism'],
      isFeatured: true,
      readTimeMinutes: 5,
    ),
    News(
      id: '2',
      title: 'Ramsey Grammar School Achieves Outstanding Ofsted Rating',
      description:
          'Local secondary school receives highest possible rating in recent inspection.',
      content:
          'Ramsey Grammar School has been awarded an Outstanding rating by Ofsted inspectors, placing it among the top-performing schools on the Isle of Man. The report praised the school\'s academic excellence and strong community links...',
      publishedDate: DateTime.now().subtract(const Duration(hours: 8)),
      imageUrl:
          'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=400&h=200&fit=crop',
      author: 'James Quirk',
      category: NewsCategory.budgeting, // Education/Community
      tags: ['education', 'school', 'achievement'],
      isFeatured: true,
      readTimeMinutes: 4,
    ),
    News(
      id: '3',
      title: 'New Electric Bus Service Connects Ramsey to Douglas',
      description:
          'Eco-friendly transport initiative launches with regular services between north and south.',
      content:
          'A new electric bus service has been launched connecting Ramsey to Douglas, providing an environmentally friendly transport option for commuters and visitors. The service runs every 30 minutes during peak hours...',
      publishedDate: DateTime.now().subtract(const Duration(days: 1)),
      imageUrl:
          'https://images.unsplash.com/photo-1570125909232-eb263c188f7e?w=400&h=200&fit=crop',
      author: 'Sarah Craine',
      category: NewsCategory.investing, // Transport/Environment
      tags: ['transport', 'electric', 'environment'],
      isFeatured: false,
      readTimeMinutes: 3,
    ),
    News(
      id: '4',
      title: 'Ramsey Farmers Market Celebrates 10th Anniversary',
      description:
          'Local market continues to grow, supporting island producers and bringing community together.',
      content:
          'The popular Ramsey Farmers Market is celebrating its 10th anniversary this weekend with special events and activities. What started as a small gathering of local producers has grown into one of the island\'s most popular weekly events...',
      publishedDate: DateTime.now().subtract(const Duration(days: 2)),
      imageUrl:
          'https://images.unsplash.com/photo-1488459716781-31db52582fe9?w=400&h=200&fit=crop',
      author: 'Peter Kneale',
      category: NewsCategory.budgeting, // Local Community
      tags: ['farmers market', 'local produce', 'community'],
      isFeatured: false,
      readTimeMinutes: 4,
    ),
    News(
      id: '5',
      title: 'Mooragh Park Lake Restoration Project Begins',
      description:
          'Major conservation work starts to preserve Ramsey\'s beloved lake and park facilities.',
      content:
          'Work has begun on the comprehensive restoration of Mooragh Park Lake, one of Ramsey\'s most cherished green spaces. The project will improve water quality, enhance wildlife habitats, and upgrade visitor facilities...',
      publishedDate: DateTime.now().subtract(const Duration(days: 3)),
      imageUrl:
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=200&fit=crop',
      author: 'Helen Gelling',
      category: NewsCategory.realEstate, // Environment/Parks
      tags: ['mooragh park', 'conservation', 'wildlife'],
      isFeatured: true,
      readTimeMinutes: 6,
    ),
    News(
      id: '6',
      title: 'Ramsey Football Club Secures Promotion to Premier League',
      description:
          'Local team\'s stellar season culminates in promotion to island\'s top football division.',
      content:
          'Ramsey Football Club has secured promotion to the Isle of Man Premier League following an exceptional season. The team\'s success has brought the whole town together in celebration...',
      publishedDate: DateTime.now().subtract(const Duration(days: 4)),
      imageUrl:
          'https://images.unsplash.com/photo-1431324155629-1a6deb1dec8d?w=400&h=200&fit=crop',
      author: 'Michael Kelly',
      category: NewsCategory.debt, // Sports/Community
      tags: ['football', 'sport', 'promotion'],
      isFeatured: false,
      readTimeMinutes: 5,
    ),
    News(
      id: '7',
      title: 'Historic Ramsey Courthouse Restoration Unveiled',
      description:
          'Grade II listed building reopens after extensive renovation, housing new community services.',
      content:
          'The historic Ramsey Courthouse has reopened its doors following an extensive restoration project. The Grade II listed building now houses community services and a heritage center showcasing the town\'s rich history...',
      publishedDate: DateTime.now().subtract(const Duration(days: 6)),
      imageUrl:
          'https://images.unsplash.com/photo-1467103956184-29135c4bf58e?w=400&h=200&fit=crop',
      author: 'Anne Christian',
      category: NewsCategory.realEstate,
      tags: ['heritage', 'restoration', 'community'],
      isFeatured: false,
      readTimeMinutes: 7,
    ),
    News(
      id: '8',
      title: 'Ramsey Bay Marine Protected Area Shows Conservation Success',
      description:
          'Wildlife surveys reveal significant improvement in marine biodiversity around Ramsey coastline.',
      content:
          'Recent marine surveys in Ramsey Bay have shown remarkable success in conservation efforts. The protected area status has led to increased fish populations and the return of several marine species...',
      publishedDate: DateTime.now().subtract(const Duration(days: 7)),
      imageUrl:
          'https://images.unsplash.com/photo-1583212292454-1fe6229603b7?w=400&h=200&fit=crop',
      author: 'Dr. Rachel Corrin',
      category: NewsCategory.investing, // Environment
      tags: ['marine conservation', 'wildlife', 'environment'],
      isFeatured: false,
      readTimeMinutes: 8,
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
