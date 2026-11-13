import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../theme.dart';

/// Vertical card used in the grid and in the horizontal "Popular" row.
/// Uses a Stack to put the "Popular" badge and the add button
/// on top of the card content.
class FoodGridCard extends StatelessWidget {
  final FoodItem item;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onTap;

  /// Hero tag must be unique on a screen. The popular row passes its own
  /// tag so it doesn't clash with the same dish in the grid below.
  final String? heroTag;

  const FoodGridCard({
    super.key,
    required this.item,
    required this.quantity,
    required this.onAdd,
    required this.onTap,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shadowColor: Colors.black12,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Hero(
                      tag: heroTag ?? 'food-${item.name}',
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          item.emoji,
                          style: const TextStyle(fontSize: 48),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.dark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: AppColors.accent),
                      const SizedBox(width: 2),
                      Text(
                        item.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Rs. ${item.price}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            // "Popular" ribbon in the top-left corner
            if (item.isPopular)
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: const Text(
                    '🔥 Popular',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            // Add button in the bottom-right corner
            Positioned(
              right: 8,
              bottom: 8,
              child: GestureDetector(
                onTap: onAdd,
                child: Container(
                  height: 34,
                  constraints: const BoxConstraints(minWidth: 34),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: quantity == 0 ? AppColors.primary : AppColors.accent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: quantity == 0
                      ? const Icon(Icons.add, color: Colors.white, size: 20)
                      : Text(
                          '$quantity in cart',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.dark,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
