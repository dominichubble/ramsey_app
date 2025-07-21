import 'package:flutter/material.dart';

import '../../services/restaurant_service.dart';
import '../common/custom_button.dart';
import '../cards/restaurant_card.dart';
import '../../screens/restaurants/restaurants_screen.dart';
import '../../screens/restaurants/restaurant_detail_screen.dart';

class RestaurantsSection extends StatelessWidget {
  final Function(int)? onNavigateToTab;

  const RestaurantsSection({super.key, this.onNavigateToTab});

  @override
  Widget build(BuildContext context) {
    final restaurantService = RestaurantService();
    final restaurants = restaurantService.getHomePageRestaurants(limit: 6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.restaurant_outlined,
                    size: 28,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Food & Drink',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              CustomButton(
                text: 'See All',
                onPressed: () {
                  // Navigate to food & drink tab or screen
                  if (onNavigateToTab != null) {
                    onNavigateToTab!(3); // Food & Drink is tab index 3
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RestaurantsScreen(),
                      ),
                    );
                  }
                },
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                width: 100,
              ),
            ],
          ),
        ),

        // Restaurant cards as column (no inner scroll)
        restaurants.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 40.0,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.restaurant_outlined,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No restaurants available',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Check back later for dining options',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: restaurants.map((restaurant) {
                    return RestaurantCard(
                      restaurant: restaurant,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RestaurantDetailScreen(restaurant: restaurant),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),

        const SizedBox(height: 16),
      ],
    );
  }
}
