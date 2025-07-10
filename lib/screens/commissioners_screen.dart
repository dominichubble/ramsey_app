import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class CommissionersScreen extends StatelessWidget {
  const CommissionersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Commissioners',
        automaticallyImplyLeading: false,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Commissioners',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Connect with local commissioners and government representatives on the Isle of Man.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 32),

            // Commissioner Categories
            _CommissionerCard(
              title: 'Local Commissioners',
              subtitle: 'Your local government representatives',
              icon: Icons.account_balance,
              color: Colors.blue,
            ),
            SizedBox(height: 16),

            _CommissionerCard(
              title: 'Parish Commissioners',
              subtitle: 'Parish-level government officials',
              icon: Icons.location_city,
              color: Colors.green,
            ),
            SizedBox(height: 16),

            _CommissionerCard(
              title: 'Government Departments',
              subtitle: 'Isle of Man government departments',
              icon: Icons.business,
              color: Colors.orange,
            ),
            SizedBox(height: 16),

            _CommissionerCard(
              title: 'Contact Information',
              subtitle: 'How to reach your representatives',
              icon: Icons.contact_mail,
              color: Colors.purple,
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
              'We\'re working on bringing you comprehensive information about local commissioners, their contact details, and how to engage with local government.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommissionerCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _CommissionerCard({
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
