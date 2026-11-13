import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../theme.dart';

/// ListView screen: restaurants near the user.
/// ListView.builder only builds the rows that are visible on screen.
class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurants near you')),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return Card(
            color: Colors.white,
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 6,
              ),
              leading: CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.accent.withValues(alpha: 0.25),
                child: Text(
                  restaurant.emoji,
                  style: const TextStyle(fontSize: 26),
                ),
              ),
              title: Text(
                restaurant.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${restaurant.cuisine} • ${restaurant.area}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, size: 16, color: AppColors.accent),
                      Text(
                        restaurant.rating.toStringAsFixed(1),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${restaurant.deliveryMinutes} min',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.muted,
                    ),
                  ),
                ],
              ),
              onTap: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('${restaurant.name} menu coming soon!'),
                    ),
                  );
              },
            ),
          );
        },
      ),
    );
  }
}
