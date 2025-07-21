import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/event.dart';
import '../models/news.dart';
import '../models/restaurant.dart';

class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  Map<String, dynamic>? _appData;

  /// Load app data from JSON file
  Future<void> loadAppData() async {
    if (_appData != null) return; // Already loaded

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/app_data.json',
      );
      _appData = json.decode(jsonString);
    } catch (e) {
      print('Error loading app data: $e');
      _appData = {}; // Initialize with empty data
    }
  }

  /// Get all events from JSON data
  Future<List<Event>> getEventsFromJson() async {
    await loadAppData();

    final List<dynamic> eventsJson = _appData?['events'] ?? [];
    return eventsJson.map((eventJson) => Event.fromMap(eventJson)).toList();
  }

  /// Get all news from JSON data
  Future<List<News>> getNewsFromJson() async {
    await loadAppData();

    final List<dynamic> newsJson = _appData?['news'] ?? [];
    return newsJson.map((newsData) {
      return News(
        id: newsData['id'] ?? '',
        title: newsData['title'] ?? '',
        description: newsData['description'] ?? '',
        content: newsData['content'] ?? '',
        publishedDate: DateTime.parse(
          newsData['publishedDate'] ?? DateTime.now().toIso8601String(),
        ),
        imageUrl: newsData['imageUrl'],
        author: newsData['author'],
        category: _parseNewsCategory(newsData['category']),
        tags: List<String>.from(newsData['tags'] ?? []),
        isFeatured: newsData['isFeatured'] ?? false,
        readTimeMinutes: newsData['readTimeMinutes'] ?? 3,
      );
    }).toList();
  }

  /// Get all restaurants from JSON data
  Future<List<Restaurant>> getRestaurantsFromJson() async {
    await loadAppData();

    final List<dynamic> restaurantsJson = _appData?['restaurants'] ?? [];
    return restaurantsJson.map((restaurantData) {
      return Restaurant(
        id: restaurantData['id'] ?? '',
        title: restaurantData['title'] ?? '',
        description: restaurantData['description'] ?? '',
        location: restaurantData['location'] ?? '',
        address: restaurantData['address'] ?? '',
        latitude: (restaurantData['latitude'] ?? 0.0).toDouble(),
        longitude: (restaurantData['longitude'] ?? 0.0).toDouble(),
        distance: (restaurantData['distance'] ?? 0.0).toDouble(),
        likes: restaurantData['likes'] ?? 0,
        rating: (restaurantData['rating'] ?? 0.0).toDouble(),
        totalReviews: restaurantData['totalReviews'] ?? 0,
        foodImages: List<String>.from(restaurantData['foodImages'] ?? []),
        coverImageUrl: restaurantData['coverImageUrl'] ?? '',
        cuisineType: _parseCuisineType(restaurantData['cuisineType']),
        priceRange: _parsePriceRange(restaurantData['priceRange']),
        phoneNumber: restaurantData['phoneNumber'],
        email: restaurantData['email'],
        website: restaurantData['website'],
        openingHours: Map<String, String>.from(
          restaurantData['openingHours'] ?? {},
        ),
        isOpen: restaurantData['isOpen'] ?? false,
        acceptsReservations: restaurantData['acceptsReservations'] ?? false,
        hasDelivery: restaurantData['hasDelivery'] ?? false,
        hasTakeout: restaurantData['hasTakeout'] ?? false,
        hasWifi: restaurantData['hasWifi'] ?? false,
        hasParking: restaurantData['hasParking'] ?? false,
        isWheelchairAccessible:
            restaurantData['isWheelchairAccessible'] ?? false,
        paymentMethods: List<String>.from(
          restaurantData['paymentMethods'] ?? [],
        ),
        tags: List<String>.from(restaurantData['tags'] ?? []),
        menu: _parseMenuItems(restaurantData['menu'] ?? []),
      );
    }).toList();
  }

  /// Get app metadata
  Future<Map<String, dynamic>> getAppMetadata() async {
    await loadAppData();
    return _appData?['appMetadata'] ?? {};
  }

  /// Get categories information
  Future<Map<String, dynamic>> getCategories() async {
    await loadAppData();
    return _appData?['categories'] ?? {};
  }

  /// Helper method to parse news category
  NewsCategory _parseNewsCategory(String? categoryString) {
    switch (categoryString) {
      case 'townCouncil':
        return NewsCategory.townCouncil;
      case 'community':
        return NewsCategory.community;
      case 'events':
        return NewsCategory.events;
      case 'development':
        return NewsCategory.development;
      case 'transport':
        return NewsCategory.transport;
      case 'environment':
        return NewsCategory.environment;
      case 'heritage':
        return NewsCategory.heritage;
      case 'sports':
        return NewsCategory.sports;
      case 'education':
        return NewsCategory.education;
      case 'business':
        return NewsCategory.business;
      default:
        return NewsCategory.general;
    }
  }

  /// Helper method to parse cuisine type
  CuisineType _parseCuisineType(String? cuisineString) {
    switch (cuisineString) {
      case 'italian':
        return CuisineType.italian;
      case 'chinese':
        return CuisineType.chinese;
      case 'mexican':
        return CuisineType.mexican;
      case 'indian':
        return CuisineType.indian;
      case 'american':
        return CuisineType.american;
      case 'japanese':
        return CuisineType.japanese;
      case 'thai':
        return CuisineType.thai;
      case 'french':
        return CuisineType.french;
      case 'mediterranean':
        return CuisineType.mediterranean;
      case 'korean':
        return CuisineType.korean;
      default:
        return CuisineType.other;
    }
  }

  /// Helper method to parse price range
  PriceRange _parsePriceRange(String? priceString) {
    switch (priceString) {
      case 'budget':
        return PriceRange.budget;
      case 'moderate':
        return PriceRange.moderate;
      case 'expensive':
        return PriceRange.expensive;
      case 'luxury':
        return PriceRange.luxury;
      default:
        return PriceRange.moderate;
    }
  }

  /// Helper method to parse menu items
  List<MenuItem> _parseMenuItems(List<dynamic> menuJson) {
    return menuJson.map((menuData) {
      return MenuItem(
        id: menuData['id'] ?? '',
        name: menuData['name'] ?? '',
        description: menuData['description'] ?? '',
        price: (menuData['price'] ?? 0.0).toDouble(),
        category: menuData['category'] ?? '',
        imageUrl: menuData['imageUrl'],
        isVegetarian: menuData['isVegetarian'] ?? false,
        isVegan: menuData['isVegan'] ?? false,
        isGlutenFree: menuData['isGlutenFree'] ?? false,
        isSpicy: menuData['isSpicy'] ?? false,
        allergens: List<String>.from(menuData['allergens'] ?? []),
      );
    }).toList();
  }

  /// Clear cached data (useful for testing or forcing refresh)
  void clearCache() {
    _appData = null;
  }
}
