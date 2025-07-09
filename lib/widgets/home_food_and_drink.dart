import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';

class HomeFoodAndDrink extends StatelessWidget {
  const HomeFoodAndDrink({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Food & Drink',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              CustomButton(
                text: 'See All',
                onPressed: () {
                  // Handle see all action
                },
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                width: 100,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
