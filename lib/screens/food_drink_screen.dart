import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../services/restaurant_service.dart';
import '../models/restaurant.dart';
import '../widgets/restaurant_card.dart';
import 'restaurant_detail_screen.dart';

class FoodDrinkScreen extends StatefulWidget {
  const FoodDrinkScreen({super.key});

  @override
  State<FoodDrinkScreen> createState() => _FoodDrinkScreenState();
}

class _FoodDrinkScreenState extends State<FoodDrinkScreen> {
  final RestaurantService _restaurantService = RestaurantService();
  CuisineType? _selectedCuisine;
  PriceRange? _selectedPriceRange;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<Restaurant> get _filteredRestaurants {
    List<Restaurant> restaurants = _restaurantService.getAllRestaurants();

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      restaurants = restaurants.where((restaurant) {
        return restaurant.title.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ) ||
            restaurant.description.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ) ||
            restaurant.cuisineDisplayName.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ) ||
            restaurant.tags.any(
              (tag) => tag.toLowerCase().contains(_searchQuery.toLowerCase()),
            );
      }).toList();
    }

    // Apply cuisine filter
    if (_selectedCuisine != null) {
      restaurants = restaurants
          .where((restaurant) => restaurant.cuisineType == _selectedCuisine)
          .toList();
    }

    // Apply price range filter
    if (_selectedPriceRange != null) {
      restaurants = restaurants
          .where((restaurant) => restaurant.priceRange == _selectedPriceRange)
          .toList();
    }

    return restaurants;
  }

  @override
  Widget build(BuildContext context) {
    final filteredRestaurants = _filteredRestaurants;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Food & Drink',
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Header and Search
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.restaurant,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Restaurants & Dining',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Discover the best dining experiences in Ramsey',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),

                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search restaurants, cuisine, or dishes...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ],
            ),
          ),

          // Filters
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                // All filter chip
                Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: const Text('All'),
                    selected:
                        _selectedCuisine == null && _selectedPriceRange == null,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCuisine = null;
                        _selectedPriceRange = null;
                      });
                    },
                    backgroundColor: Colors.grey[200],
                    selectedColor: Theme.of(context).primaryColor,
                    labelStyle: TextStyle(
                      color:
                          (_selectedCuisine == null &&
                              _selectedPriceRange == null)
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      fontWeight:
                          (_selectedCuisine == null &&
                              _selectedPriceRange == null)
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),

                // Price range filters
                ...PriceRange.values.map((priceRange) {
                  final isSelected = _selectedPriceRange == priceRange;
                  return Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(_getPriceRangeSymbol(priceRange)),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedPriceRange = selected ? priceRange : null;
                        });
                      },
                      backgroundColor: Colors.grey[200],
                      selectedColor: _getPriceRangeColor(priceRange),
                      labelStyle: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : _getPriceRangeColor(priceRange),
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  );
                }),

                // Cuisine filters
                ...CuisineType.values.take(5).map((cuisine) {
                  final isSelected = _selectedCuisine == cuisine;
                  return Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(_getCuisineDisplayName(cuisine)),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCuisine = selected ? cuisine : null;
                        });
                      },
                      backgroundColor: Colors.grey[200],
                      selectedColor: _getCuisineColor(cuisine),
                      labelStyle: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : _getCuisineColor(cuisine),
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
                  '${filteredRestaurants.length} restaurants found',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Restaurant List
          Expanded(
            child: filteredRestaurants.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.restaurant_menu,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No restaurants found',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your search or filters',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: filteredRestaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = filteredRestaurants[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: RestaurantCard(
                          restaurant: restaurant,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RestaurantDetailScreen(
                                  restaurant: restaurant,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String _getPriceRangeSymbol(PriceRange priceRange) {
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

  Color _getPriceRangeColor(PriceRange priceRange) {
    switch (priceRange) {
      case PriceRange.budget:
        return Colors.green;
      case PriceRange.moderate:
        return Colors.orange;
      case PriceRange.expensive:
        return Colors.red;
      case PriceRange.luxury:
        return Colors.purple;
    }
  }

  String _getCuisineDisplayName(CuisineType cuisine) {
    switch (cuisine) {
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
        return 'Local';
    }
  }

  Color _getCuisineColor(CuisineType cuisine) {
    switch (cuisine) {
      case CuisineType.italian:
        return Colors.red;
      case CuisineType.chinese:
        return Colors.amber;
      case CuisineType.mexican:
        return Colors.orange;
      case CuisineType.indian:
        return Colors.deepOrange;
      case CuisineType.american:
        return Colors.blue;
      case CuisineType.japanese:
        return Colors.pink;
      case CuisineType.thai:
        return Colors.green;
      case CuisineType.french:
        return Colors.purple;
      case CuisineType.mediterranean:
        return Colors.teal;
      case CuisineType.korean:
        return Colors.indigo;
      case CuisineType.other:
        return Colors.brown;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
