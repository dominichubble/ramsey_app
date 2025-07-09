enum CuisineType {
  italian,
  chinese,
  mexican,
  indian,
  american,
  japanese,
  thai,
  french,
  mediterranean,
  korean,
  other,
}

enum PriceRange {
  budget, // $
  moderate, // $$
  expensive, // $$$
  luxury, // $$$$
}

class RestaurantReview {
  final String id;
  final String userName;
  final String userAvatar;
  final double rating;
  final String comment;
  final DateTime reviewDate;
  final List<String> images;

  const RestaurantReview({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.comment,
    required this.reviewDate,
    this.images = const [],
  });
}

class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String? imageUrl;
  final bool isVegetarian;
  final bool isVegan;
  final bool isGlutenFree;
  final bool isSpicy;
  final List<String> allergens;

  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.imageUrl,
    this.isVegetarian = false,
    this.isVegan = false,
    this.isGlutenFree = false,
    this.isSpicy = false,
    this.allergens = const [],
  });
}

class Restaurant {
  final String id;
  final String title;
  final String description;
  final String location;
  final String address;
  final double latitude;
  final double longitude;
  final double distance; // in miles or kilometers
  final int likes;
  final double rating;
  final int totalReviews;
  final List<RestaurantReview> reviews;
  final List<String> foodImages;
  final List<MenuItem> menu;
  final String? logoUrl;
  final String? coverImageUrl;
  final CuisineType cuisineType;
  final PriceRange priceRange;
  final String phoneNumber;
  final String email;
  final String website;
  final Map<String, String>
  openingHours; // day -> hours (e.g., "Monday" -> "9:00 AM - 10:00 PM")
  final bool isOpen;
  final bool acceptsReservations;
  final bool hasDelivery;
  final bool hasTakeout;
  final bool hasWifi;
  final bool hasParking;
  final bool isWheelchairAccessible;
  final List<String> paymentMethods;
  final List<String> tags;
  final DateTime? lastUpdated;

  const Restaurant({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.distance,
    this.likes = 0,
    this.rating = 0.0,
    this.totalReviews = 0,
    this.reviews = const [],
    this.foodImages = const [],
    this.menu = const [],
    this.logoUrl,
    this.coverImageUrl,
    this.cuisineType = CuisineType.other,
    this.priceRange = PriceRange.moderate,
    this.phoneNumber = '',
    this.email = '',
    this.website = '',
    this.openingHours = const {},
    this.isOpen = false,
    this.acceptsReservations = false,
    this.hasDelivery = false,
    this.hasTakeout = false,
    this.hasWifi = false,
    this.hasParking = false,
    this.isWheelchairAccessible = false,
    this.paymentMethods = const [],
    this.tags = const [],
    this.lastUpdated,
  });

  // Utility getters
  String get cuisineDisplayName {
    switch (cuisineType) {
      case CuisineType.italian:
        return 'Italian';
      case CuisineType.chinese:
        return 'Chinese';
      case CuisineType.mexican:
        return 'Mexican';
      case CuisineType.indian:
        return 'Indian';
      case CuisineType.american:
        return 'American';
      case CuisineType.japanese:
        return 'Japanese';
      case CuisineType.thai:
        return 'Thai';
      case CuisineType.french:
        return 'French';
      case CuisineType.mediterranean:
        return 'Mediterranean';
      case CuisineType.korean:
        return 'Korean';
      case CuisineType.other:
        return 'Other';
    }
  }

  String get priceRangeSymbol {
    switch (priceRange) {
      case PriceRange.budget:
        return '\$';
      case PriceRange.moderate:
        return '\$\$';
      case PriceRange.expensive:
        return '\$\$\$';
      case PriceRange.luxury:
        return '\$\$\$\$';
    }
  }

  String get formattedDistance {
    if (distance < 1) {
      return '${(distance * 1000).round()}m away';
    } else {
      return '${distance.toStringAsFixed(1)}km away';
    }
  }

  String get formattedRating {
    return rating.toStringAsFixed(1);
  }

  bool get hasHighRating => rating >= 4.0;

  bool get isPopular => likes > 100;

  List<String> get menuCategories {
    return menu.map((item) => item.category).toSet().toList();
  }

  List<MenuItem> getMenuByCategory(String category) {
    return menu.where((item) => item.category == category).toList();
  }

  // Factory constructor for creating from JSON
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      address: json['address'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      distance: (json['distance'] ?? 0.0).toDouble(),
      likes: json['likes'] ?? 0,
      rating: (json['rating'] ?? 0.0).toDouble(),
      totalReviews: json['totalReviews'] ?? 0,
      reviews:
          (json['reviews'] as List<dynamic>?)
              ?.map(
                (reviewJson) => RestaurantReview(
                  id: reviewJson['id'] ?? '',
                  userName: reviewJson['userName'] ?? '',
                  userAvatar: reviewJson['userAvatar'] ?? '',
                  rating: (reviewJson['rating'] ?? 0.0).toDouble(),
                  comment: reviewJson['comment'] ?? '',
                  reviewDate: DateTime.parse(
                    reviewJson['reviewDate'] ??
                        DateTime.now().toIso8601String(),
                  ),
                  images: List<String>.from(reviewJson['images'] ?? []),
                ),
              )
              .toList() ??
          [],
      foodImages: List<String>.from(json['foodImages'] ?? []),
      menu:
          (json['menu'] as List<dynamic>?)
              ?.map(
                (menuJson) => MenuItem(
                  id: menuJson['id'] ?? '',
                  name: menuJson['name'] ?? '',
                  description: menuJson['description'] ?? '',
                  price: (menuJson['price'] ?? 0.0).toDouble(),
                  category: menuJson['category'] ?? '',
                  imageUrl: menuJson['imageUrl'],
                  isVegetarian: menuJson['isVegetarian'] ?? false,
                  isVegan: menuJson['isVegan'] ?? false,
                  isGlutenFree: menuJson['isGlutenFree'] ?? false,
                  isSpicy: menuJson['isSpicy'] ?? false,
                  allergens: List<String>.from(menuJson['allergens'] ?? []),
                ),
              )
              .toList() ??
          [],
      logoUrl: json['logoUrl'],
      coverImageUrl: json['coverImageUrl'],
      cuisineType: CuisineType.values.firstWhere(
        (type) => type.toString() == 'CuisineType.${json['cuisineType']}',
        orElse: () => CuisineType.other,
      ),
      priceRange: PriceRange.values.firstWhere(
        (range) => range.toString() == 'PriceRange.${json['priceRange']}',
        orElse: () => PriceRange.moderate,
      ),
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      website: json['website'] ?? '',
      openingHours: Map<String, String>.from(json['openingHours'] ?? {}),
      isOpen: json['isOpen'] ?? false,
      acceptsReservations: json['acceptsReservations'] ?? false,
      hasDelivery: json['hasDelivery'] ?? false,
      hasTakeout: json['hasTakeout'] ?? false,
      hasWifi: json['hasWifi'] ?? false,
      hasParking: json['hasParking'] ?? false,
      isWheelchairAccessible: json['isWheelchairAccessible'] ?? false,
      paymentMethods: List<String>.from(json['paymentMethods'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      lastUpdated:
          json['lastUpdated'] != null
              ? DateTime.parse(json['lastUpdated'])
              : null,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'distance': distance,
      'likes': likes,
      'rating': rating,
      'totalReviews': totalReviews,
      'reviews':
          reviews
              .map(
                (review) => {
                  'id': review.id,
                  'userName': review.userName,
                  'userAvatar': review.userAvatar,
                  'rating': review.rating,
                  'comment': review.comment,
                  'reviewDate': review.reviewDate.toIso8601String(),
                  'images': review.images,
                },
              )
              .toList(),
      'foodImages': foodImages,
      'menu':
          menu
              .map(
                (item) => {
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'price': item.price,
                  'category': item.category,
                  'imageUrl': item.imageUrl,
                  'isVegetarian': item.isVegetarian,
                  'isVegan': item.isVegan,
                  'isGlutenFree': item.isGlutenFree,
                  'isSpicy': item.isSpicy,
                  'allergens': item.allergens,
                },
              )
              .toList(),
      'logoUrl': logoUrl,
      'coverImageUrl': coverImageUrl,
      'cuisineType': cuisineType.toString().split('.').last,
      'priceRange': priceRange.toString().split('.').last,
      'phoneNumber': phoneNumber,
      'email': email,
      'website': website,
      'openingHours': openingHours,
      'isOpen': isOpen,
      'acceptsReservations': acceptsReservations,
      'hasDelivery': hasDelivery,
      'hasTakeout': hasTakeout,
      'hasWifi': hasWifi,
      'hasParking': hasParking,
      'isWheelchairAccessible': isWheelchairAccessible,
      'paymentMethods': paymentMethods,
      'tags': tags,
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }

  // Create a copy with modified properties
  Restaurant copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    String? address,
    double? latitude,
    double? longitude,
    double? distance,
    int? likes,
    double? rating,
    int? totalReviews,
    List<RestaurantReview>? reviews,
    List<String>? foodImages,
    List<MenuItem>? menu,
    String? logoUrl,
    String? coverImageUrl,
    CuisineType? cuisineType,
    PriceRange? priceRange,
    String? phoneNumber,
    String? email,
    String? website,
    Map<String, String>? openingHours,
    bool? isOpen,
    bool? acceptsReservations,
    bool? hasDelivery,
    bool? hasTakeout,
    bool? hasWifi,
    bool? hasParking,
    bool? isWheelchairAccessible,
    List<String>? paymentMethods,
    List<String>? tags,
    DateTime? lastUpdated,
  }) {
    return Restaurant(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      distance: distance ?? this.distance,
      likes: likes ?? this.likes,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      reviews: reviews ?? this.reviews,
      foodImages: foodImages ?? this.foodImages,
      menu: menu ?? this.menu,
      logoUrl: logoUrl ?? this.logoUrl,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      cuisineType: cuisineType ?? this.cuisineType,
      priceRange: priceRange ?? this.priceRange,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      website: website ?? this.website,
      openingHours: openingHours ?? this.openingHours,
      isOpen: isOpen ?? this.isOpen,
      acceptsReservations: acceptsReservations ?? this.acceptsReservations,
      hasDelivery: hasDelivery ?? this.hasDelivery,
      hasTakeout: hasTakeout ?? this.hasTakeout,
      hasWifi: hasWifi ?? this.hasWifi,
      hasParking: hasParking ?? this.hasParking,
      isWheelchairAccessible:
          isWheelchairAccessible ?? this.isWheelchairAccessible,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      tags: tags ?? this.tags,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  String toString() {
    return 'Restaurant(id: $id, title: $title, location: $location, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Restaurant && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
