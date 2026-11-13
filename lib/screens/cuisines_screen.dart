import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../theme.dart';

/// GridView screen: pick a cuisine. Tapping a tile pops back to the
/// home screen and returns the chosen category, which the home screen
/// uses to filter the menu.
class CuisinesScreen extends StatelessWidget {
  const CuisinesScreen({super.key});

  static const _tiles = [
    ('All', '🍽️', 'Everything on the menu', Color(0xFF1E6F5C)),
    ('Desi', '🍛', 'Biryani, karahi, nihari', Color(0xFFE76F51)),
    ('Fast Food', '🍔', 'Burgers, pizza, fries', Color(0xFFF4A261)),
    ('BBQ', '🍢', 'Tikka, kababs, boti', Color(0xFF9C6644)),
    ('Drinks', '🥤', 'Lassi, chai, soda', Color(0xFF2A9D8F)),
    ('Desserts', '🍰', 'Kheer, jamun, cake', Color(0xFFB5838D)),
  ];

  int _countFor(String category) {
    if (category == 'All') return menuItems.length;
    return menuItems.where((item) => item.category == category).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cuisines')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 4, 20, 8),
            child: Text(
              'What are you craving today?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.dark,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: _tiles.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final (name, emoji, subtitle, color) = _tiles[index];
                return Card(
                  elevation: 0,
                  color: color.withValues(alpha: 0.12),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () => Navigator.pop(context, name),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                emoji,
                                style: const TextStyle(fontSize: 56),
                              ),
                            ),
                          ),
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: color,
                            ),
                          ),
                          Text(
                            subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.muted,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_countFor(name)} dishes',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
