import 'package:flutter/material.dart';

// Simple test version of NewsCard with hardcoded values
class TestNewsCard extends StatelessWidget {
  const TestNewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.blue[300],
            child: const Center(
              child: Text(
                'Test Image Placeholder',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Test News Title',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              'This is a test description to see if the NewsCard widget structure is working properly.',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
