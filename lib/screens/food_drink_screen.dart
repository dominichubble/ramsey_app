import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class FoodDrinkScreen extends StatelessWidget {
  const FoodDrinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Food & Drink',
        automaticallyImplyLeading: false,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Food & Drink',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Discover the best dining experiences and beverage options on the Isle of Man.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 32),

            // Restaurant Categories
            _CategoryCard(
              title: 'Restaurants',
              subtitle: 'Fine dining and casual eateries',
              icon: Icons.restaurant,
              color: Colors.orange,
            ),
            SizedBox(height: 16),

            _CategoryCard(
              title: 'Pubs & Bars',
              subtitle: 'Traditional pubs and modern bars',
              icon: Icons.local_bar,
              color: Colors.amber,
            ),
            SizedBox(height: 16),

            _CategoryCard(
              title: 'Cafés',
              subtitle: 'Coffee shops and light meals',
              icon: Icons.local_cafe,
              color: Colors.brown,
            ),
            SizedBox(height: 16),

            _CategoryCard(
              title: 'Local Specialties',
              subtitle: 'Manx cuisine and traditional dishes',
              icon: Icons.dinner_dining,
              color: Colors.green,
            ),
            SizedBox(height: 32),

            Text(
              'Coming Soon',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We\'re working on bringing you comprehensive food and drink recommendations. Stay tuned for restaurant reviews, menus, and booking options.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _CategoryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title section coming soon!'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
