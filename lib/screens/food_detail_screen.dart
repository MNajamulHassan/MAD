import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../theme.dart';

/// Detail page for one dish. The emoji flies in with a Hero animation.
/// When the user taps "Add to cart" we pop and RETURN the quantity
/// back to the home screen (returning data from a screen).
class FoodDetailScreen extends StatefulWidget {
  final FoodItem item;

  const FoodDetailScreen({super.key, required this.item});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      appBar: AppBar(title: Text(item.category)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Hero(
                  tag: 'food-${item.name}',
                  child: Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Text(item.emoji, style: const TextStyle(fontSize: 110)),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.description,
                style: const TextStyle(fontSize: 15, color: AppColors.muted),
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Icon(Icons.timer_outlined, size: 18, color: AppColors.primary),
                  SizedBox(width: 4),
                  Text('25-35 min'),
                  SizedBox(width: 20),
                  Icon(Icons.star, size: 18, color: AppColors.accent),
                  SizedBox(width: 4),
                  Text('4.6'),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  _roundButton(Icons.remove, () {
                    if (_quantity > 1) setState(() => _quantity--);
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '$_quantity',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _roundButton(Icons.add, () => setState(() => _quantity++)),
                  const Spacer(),
                  Text(
                    'Rs. ${item.price * _quantity}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context, _quantity),
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Add to cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roundButton(IconData icon, VoidCallback onPressed) {
    return IconButton.outlined(
      onPressed: onPressed,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        side: const BorderSide(color: AppColors.primary),
        foregroundColor: AppColors.primary,
      ),
    );
  }
}
