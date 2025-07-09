import '../models/restaurant.dart';

class RestaurantService {
  static final RestaurantService _instance = RestaurantService._internal();
  factory RestaurantService() => _instance;
  RestaurantService._internal();

  // Sample restaurant data for Ramsey, Isle of Man
  final List<Restaurant> _restaurants = [
    Restaurant(
      id: '1',
      title: 'The Albert Hotel Restaurant',
      description:
          'Traditional Manx cuisine and British classics in the heart of Ramsey\'s historic Albert Hotel.',
      location: 'Ramsey Town Centre',
      address: 'Parliament Square, Ramsey, Isle of Man, IM8 1AE',
      latitude: 54.3241,
      longitude: -4.3834,
      distance: 0.2,
      likes: 187,
      rating: 4.5,
      totalReviews: 94,
      foodImages: [
        'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=400&h=300&fit=crop',
        'https://images.unsplash.com/photo-1484723091739-30a097e8f929?w=400&h=300&fit=crop',
        'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=400&h=300&fit=crop',
      ],
      coverImageUrl:
          'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=400&h=300&fit=crop',
      cuisineType: CuisineType.other, // British/Manx
      priceRange: PriceRange.moderate,
      phoneNumber: '+44 1624 813901',
      email: 'restaurant@alberthotel.im',
      website: 'www.alberthotel.im',
      openingHours: {
        'Monday': '12:00 PM - 9:00 PM',
        'Tuesday': '12:00 PM - 9:00 PM',
        'Wednesday': '12:00 PM - 9:00 PM',
        'Thursday': '12:00 PM - 9:00 PM',
        'Friday': '12:00 PM - 10:00 PM',
        'Saturday': '12:00 PM - 10:00 PM',
        'Sunday': '12:00 PM - 8:00 PM',
      },
      isOpen: true,
      acceptsReservations: true,
      hasDelivery: false,
      hasTakeout: true,
      hasWifi: true,
      hasParking: true,
      isWheelchairAccessible: true,
      paymentMethods: ['Credit Card', 'Cash', 'Contactless'],
      tags: ['traditional', 'historic', 'Manx cuisine'],
      menu: [
        MenuItem(
          id: '1',
          name: 'Queenie Scallops',
          description: 'Fresh local queenie scallops served with garlic butter',
          price: 8.95,
          category: 'Starters',
          imageUrl:
              'https://images.unsplash.com/photo-1559847844-d721426d6edc?w=300&h=200&fit=crop',
        ),
        MenuItem(
          id: '2',
          name: 'Traditional Fish & Chips',
          description: 'Fresh haddock in beer batter with hand-cut chips',
          price: 12.50,
          category: 'Mains',
          imageUrl:
              'https://images.unsplash.com/photo-1544982503-9f984c14501a?w=300&h=200&fit=crop',
        ),
      ],
    ),
    Restaurant(
      id: '2',
      title: 'The Mitre Hotel & Restaurant',
      description:
          'Award-winning restaurant offering contemporary dining with stunning views of Ramsey Bay.',
      location: 'Ramsey Promenade',
      address: 'The Promenade, Ramsey, Isle of Man, IM8 1EP',
      latitude: 54.3255,
      longitude: -4.3820,
      distance: 0.4,
      likes: 312,
      rating: 4.7,
      totalReviews: 156,
      foodImages: [
        'https://images.unsplash.com/photo-1550966871-3ed3cdb5ed0c?w=400&h=300&fit=crop',
        'https://images.unsplash.com/photo-1559339352-11d035aa65de?w=400&h=300&fit=crop',
        'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400&h=300&fit=crop',
      ],
      coverImageUrl:
          'https://images.unsplash.com/photo-1550966871-3ed3cdb5ed0c?w=400&h=300&fit=crop',
      cuisineType: CuisineType.mediterranean,
      priceRange: PriceRange.expensive,
      phoneNumber: '+44 1624 816240',
      email: 'info@mitreramsey.com',
      website: 'www.mitreramsey.com',
      openingHours: {
        'Monday': 'Closed',
        'Tuesday': '6:00 PM - 9:30 PM',
        'Wednesday': '6:00 PM - 9:30 PM',
        'Thursday': '6:00 PM - 9:30 PM',
        'Friday': '6:00 PM - 10:00 PM',
        'Saturday': '6:00 PM - 10:00 PM',
        'Sunday': '12:00 PM - 8:00 PM',
      },
      isOpen: true,
      acceptsReservations: true,
      hasDelivery: false,
      hasTakeout: false,
      hasWifi: true,
      hasParking: true,
      isWheelchairAccessible: true,
      paymentMethods: ['Credit Card', 'Cash'],
      tags: ['fine dining', 'sea views', 'romantic'],
      menu: [
        MenuItem(
          id: '3',
          name: 'Isle of Man Crab Cakes',
          description: 'Local crab with herb aioli and micro greens',
          price: 11.95,
          category: 'Starters',
          imageUrl:
              'https://images.unsplash.com/photo-1559847844-d721426d6edc?w=300&h=200&fit=crop',
        ),
        MenuItem(
          id: '4',
          name: 'Manx Lamb Shank',
          description: 'Slow-cooked local lamb with seasonal vegetables',
          price: 18.95,
          category: 'Mains',
          imageUrl:
              'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=300&h=200&fit=crop',
        ),
      ],
    ),
    Restaurant(
      id: '3',
      title: 'The Harbour Bistro',
      description:
          'Cosy harbour-side bistro specializing in fresh seafood and local produce.',
      location: 'Ramsey Harbour',
      address: 'East Quay, Ramsey Harbour, Isle of Man, IM8 1ET',
      latitude: 54.3230,
      longitude: -4.3810,
      distance: 0.6,
      likes: 143,
      rating: 4.3,
      totalReviews: 89,
      foodImages: [
        'https://images.unsplash.com/photo-1559847844-d721426d6edc?w=400&h=300&fit=crop',
        'https://images.unsplash.com/photo-1544982503-9f984c14501a?w=400&h=300&fit=crop',
        'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400&h=300&fit=crop',
      ],
      coverImageUrl:
          'https://images.unsplash.com/photo-1559847844-d721426d6edc?w=400&h=300&fit=crop',
      cuisineType: CuisineType.other, // Seafood
      priceRange: PriceRange.moderate,
      phoneNumber: '+44 1624 815678',
      email: 'info@harbourbistro.im',
      website: 'www.harbourbistro.im',
      openingHours: {
        'Monday': '10:00 AM - 4:00 PM',
        'Tuesday': '10:00 AM - 4:00 PM',
        'Wednesday': '10:00 AM - 4:00 PM',
        'Thursday': '10:00 AM - 4:00 PM',
        'Friday': '10:00 AM - 9:00 PM',
        'Saturday': '10:00 AM - 9:00 PM',
        'Sunday': '10:00 AM - 6:00 PM',
      },
      isOpen: true,
      acceptsReservations: false,
      hasDelivery: false,
      hasTakeout: true,
      hasWifi: true,
      hasParking: false,
      isWheelchairAccessible: false,
      paymentMethods: ['Credit Card', 'Cash'],
      tags: ['harbour views', 'fresh seafood', 'casual'],
      menu: [
        MenuItem(
          id: '5',
          name: 'Ramsey Bay Prawns',
          description: 'Fresh local prawns with Marie Rose sauce',
          price: 7.50,
          category: 'Seafood',
          imageUrl:
              'https://images.unsplash.com/photo-1565680018434-b513d5e5fd47?w=300&h=200&fit=crop',
        ),
        MenuItem(
          id: '6',
          name: 'Fisherman\'s Pie',
          description:
              'Local fish and prawns in creamy sauce topped with mashed potato',
          price: 13.95,
          category: 'Mains',
          imageUrl:
              'https://images.unsplash.com/photo-1544982503-9f984c14501a?w=300&h=200&fit=crop',
        ),
      ],
    ),
    Restaurant(
      id: '4',
      title: 'Curragh Curry House',
      description:
          'Authentic Indian cuisine bringing the flavors of the subcontinent to Ramsey.',
      location: 'Bowring Road',
      address: '45 Bowring Road, Ramsey, Isle of Man, IM8 2DL',
      latitude: 54.3220,
      longitude: -4.3845,
      distance: 0.8,
      likes: 89,
      rating: 4.2,
      totalReviews: 67,
      foodImages: [
        'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=400&h=300&fit=crop',
        'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=400&h=300&fit=crop',
        'https://images.unsplash.com/photo-1563379091339-03246963d321?w=400&h=300&fit=crop',
      ],
      coverImageUrl:
          'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=400&h=300&fit=crop',
      cuisineType: CuisineType.indian,
      priceRange: PriceRange.moderate,
      phoneNumber: '+44 1624 814789',
      email: 'info@curraghcurry.im',
      website: 'www.curraghcurry.im',
      openingHours: {
        'Monday': '5:00 PM - 11:00 PM',
        'Tuesday': '5:00 PM - 11:00 PM',
        'Wednesday': '5:00 PM - 11:00 PM',
        'Thursday': '5:00 PM - 11:00 PM',
        'Friday': '5:00 PM - 11:30 PM',
        'Saturday': '5:00 PM - 11:30 PM',
        'Sunday': '5:00 PM - 10:30 PM',
      },
      isOpen: true,
      acceptsReservations: true,
      hasDelivery: true,
      hasTakeout: true,
      hasWifi: false,
      hasParking: true,
      isWheelchairAccessible: true,
      paymentMethods: ['Credit Card', 'Cash'],
      tags: ['spicy', 'vegetarian options', 'family run'],
      menu: [
        MenuItem(
          id: '7',
          name: 'Chicken Tikka Masala',
          description: 'Tender chicken in creamy tomato and spice sauce',
          price: 12.95,
          category: 'Curries',
          imageUrl:
              'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=300&h=200&fit=crop',
        ),
        MenuItem(
          id: '8',
          name: 'Vegetable Biryani',
          description: 'Fragrant basmati rice with mixed vegetables and spices',
          price: 10.95,
          category: 'Rice Dishes',
          imageUrl:
              'https://images.unsplash.com/photo-1563379091339-03246963d321?w=300&h=200&fit=crop',
          isVegetarian: true,
          isVegan: true,
        ),
      ],
    ),
    Restaurant(
      id: '5',
      title: 'Mooragh Cafe',
      description:
          'Popular lakeside cafe serving homemade cakes, light lunches and speciality coffee.',
      location: 'Mooragh Park',
      address: 'Mooragh Promenade, Ramsey, Isle of Man, IM8 3RF',
      latitude: 54.3265,
      longitude: -4.3800,
      distance: 1.0,
      likes: 224,
      rating: 4.4,
      totalReviews: 178,
      foodImages: [
        'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=400&h=300&fit=crop',
        'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=400&h=300&fit=crop',
        'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400&h=300&fit=crop',
      ],
      coverImageUrl:
          'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=400&h=300&fit=crop',
      cuisineType: CuisineType.other, // Cafe/British
      priceRange: PriceRange.budget,
      phoneNumber: '+44 1624 812456',
      email: 'hello@mooraghcafe.im',
      website: 'www.mooraghcafe.im',
      openingHours: {
        'Monday': '9:00 AM - 4:00 PM',
        'Tuesday': '9:00 AM - 4:00 PM',
        'Wednesday': '9:00 AM - 4:00 PM',
        'Thursday': '9:00 AM - 4:00 PM',
        'Friday': '9:00 AM - 4:00 PM',
        'Saturday': '9:00 AM - 5:00 PM',
        'Sunday': '9:00 AM - 5:00 PM',
      },
      isOpen: true,
      acceptsReservations: false,
      hasDelivery: false,
      hasTakeout: true,
      hasWifi: true,
      hasParking: true,
      isWheelchairAccessible: true,
      paymentMethods: ['Credit Card', 'Cash'],
      tags: ['family friendly', 'lake views', 'homemade'],
      menu: [
        MenuItem(
          id: '9',
          name: 'Manx Cream Tea',
          description: 'Fresh scones with jam and cream, served with tea',
          price: 6.50,
          category: 'Afternoon Tea',
          imageUrl:
              'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=300&h=200&fit=crop',
          isVegetarian: true,
        ),
        MenuItem(
          id: '10',
          name: 'Full Manx Breakfast',
          description: 'Local bacon, sausages, black pudding, eggs and beans',
          price: 8.95,
          category: 'Breakfast',
          imageUrl:
              'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=300&h=200&fit=crop',
        ),
      ],
    ),
  ];

  // Get all restaurants
  List<Restaurant> getAllRestaurants() {
    return List.unmodifiable(_restaurants);
  }

  // Get featured restaurants (high rated)
  List<Restaurant> getFeaturedRestaurants() {
    return _restaurants
        .where((restaurant) => restaurant.hasHighRating)
        .toList();
  }

  // Get popular restaurants (high likes)
  List<Restaurant> getPopularRestaurants() {
    return _restaurants.where((restaurant) => restaurant.isPopular).toList();
  }

  // Get nearby restaurants (sorted by distance)
  List<Restaurant> getNearbyRestaurants({int limit = 10}) {
    final sortedRestaurants = List<Restaurant>.from(_restaurants)
      ..sort((a, b) => a.distance.compareTo(b.distance));
    return sortedRestaurants.take(limit).toList();
  }

  // Get restaurants by cuisine type
  List<Restaurant> getRestaurantsByCuisine(CuisineType cuisineType) {
    return _restaurants
        .where((restaurant) => restaurant.cuisineType == cuisineType)
        .toList();
  }

  // Get restaurants by price range
  List<Restaurant> getRestaurantsByPriceRange(PriceRange priceRange) {
    return _restaurants
        .where((restaurant) => restaurant.priceRange == priceRange)
        .toList();
  }

  // Get open restaurants
  List<Restaurant> getOpenRestaurants() {
    return _restaurants.where((restaurant) => restaurant.isOpen).toList();
  }

  // Search restaurants by name or cuisine
  List<Restaurant> searchRestaurants(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _restaurants.where((restaurant) {
      return restaurant.title.toLowerCase().contains(lowercaseQuery) ||
          restaurant.cuisineDisplayName.toLowerCase().contains(
            lowercaseQuery,
          ) ||
          restaurant.location.toLowerCase().contains(lowercaseQuery) ||
          restaurant.tags.any(
            (tag) => tag.toLowerCase().contains(lowercaseQuery),
          );
    }).toList();
  }

  // Get restaurant by ID
  Restaurant? getRestaurantById(String id) {
    try {
      return _restaurants.firstWhere((restaurant) => restaurant.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get restaurants for home page (mix of featured and nearby)
  List<Restaurant> getHomePageRestaurants({int limit = 6}) {
    final featured = getFeaturedRestaurants().take(3).toList();
    final nearby = getNearbyRestaurants(limit: 3);

    // Combine and remove duplicates
    final combined = <String, Restaurant>{};
    for (final restaurant in [...featured, ...nearby]) {
      combined[restaurant.id] = restaurant;
    }

    return combined.values.take(limit).toList();
  }

  // Add a new restaurant (for future functionality)
  void addRestaurant(Restaurant restaurant) {
    _restaurants.add(restaurant);
  }

  // Update restaurant (for future functionality)
  void updateRestaurant(Restaurant updatedRestaurant) {
    final index = _restaurants.indexWhere(
      (restaurant) => restaurant.id == updatedRestaurant.id,
    );
    if (index != -1) {
      _restaurants[index] = updatedRestaurant;
    }
  }

  // Delete restaurant (for future functionality)
  void deleteRestaurant(String id) {
    _restaurants.removeWhere((restaurant) => restaurant.id == id);
  }

  // Like/Unlike restaurant
  Restaurant toggleLike(String restaurantId) {
    final index = _restaurants.indexWhere(
      (restaurant) => restaurant.id == restaurantId,
    );
    if (index != -1) {
      final restaurant = _restaurants[index];
      final newLikes =
          restaurant.likes + 1; // In a real app, you'd track user likes
      final updatedRestaurant = restaurant.copyWith(likes: newLikes);
      _restaurants[index] = updatedRestaurant;
      return updatedRestaurant;
    }
    throw Exception('Restaurant not found');
  }
}
