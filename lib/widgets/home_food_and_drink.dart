import 'package:flutter/material.dart';

import '../services/restaurant_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/restaurant_card.dart';

class HomeFoodAndDrink extends StatelessWidget {
  const HomeFoodAndDrink({super.key});

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
                  // TODO: Navigate to restaurants page
                  print('Navigate to all restaurants');
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
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
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: Colors.grey[500]),
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
                        // TODO: Navigate to restaurant detail page
                        print('Navigate to restaurant: ${restaurant.title}');
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
