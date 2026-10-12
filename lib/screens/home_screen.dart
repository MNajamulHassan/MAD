import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../theme.dart';
import '../widgets/food_card.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';

  // Cart: food name -> quantity
  final Map<String, int> _cart = {};

  List<FoodItem> get _visibleItems {
    if (_selectedCategory == 'All') return menuItems;
    return menuItems
        .where((item) => item.category == _selectedCategory)
        .toList();
  }

  int get _totalItems => _cart.values.fold(0, (sum, qty) => sum + qty);

  int get _totalPrice {
    int total = 0;
    for (final item in menuItems) {
      total += (_cart[item.name] ?? 0) * item.price;
    }
    return total;
  }

  void _addToCart(FoodItem item) {
    setState(() {
      _cart[item.name] = (_cart[item.name] ?? 0) + 1;
    });
  }

  void _removeFromCart(FoodItem item) {
    setState(() {
      final qty = (_cart[item.name] ?? 0) - 1;
      if (qty <= 0) {
        _cart.remove(item.name);
      } else {
        _cart[item.name] = qty;
      }
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _showCheckout() {
    const deliveryFee = 99;
    final itemsInCart =
        menuItems.where((item) => _cart.containsKey(item.name)).toList();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Your Order'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final item in itemsInCart)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Text('${item.emoji}  ${_cart[item.name]} x '),
                      Expanded(child: Text(item.name)),
                      Text('Rs. ${_cart[item.name]! * item.price}'),
                    ],
                  ),
                ),
              const Divider(),
              _summaryRow('Delivery fee', 'Rs. $deliveryFee'),
              _summaryRow(
                'Total',
                'Rs. ${_totalPrice + deliveryFee}',
                bold: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                setState(() => _cart.clear());
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Order placed! Your rider is on the way 🛵'),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
              child: const Text('Place Order'),
            ),
          ],
        );
      },
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) {
    final style = TextStyle(
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      fontSize: bold ? 16 : 14,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: style), Text(value, style: style)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, ${widget.userName} 👋',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Row(
              children: [
                Icon(Icons.location_on, size: 14, color: AppColors.primary),
                SizedBox(width: 2),
                Text(
                  'Deliver to: Rawalpindi',
                  style: TextStyle(fontSize: 12, color: AppColors.muted),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Log out',
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Promo banner
          Container(
            margin: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Free delivery',
                        style: TextStyle(
                          color: AppColors.accent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'On your first order\nabove Rs. 1500',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Text('🛵', style: TextStyle(fontSize: 48)),
              ],
            ),
          ),
          // Category chips
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                for (final category in foodCategories)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: _selectedCategory == category,
                      onSelected: (_) {
                        setState(() => _selectedCategory = category);
                      },
                      selectedColor: AppColors.accent,
                      backgroundColor: Colors.white,
                      showCheckmark: false,
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
                    ),
                  ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text(
              'Popular near you',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.dark,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              children: [
                for (final item in _visibleItems)
                  FoodCard(
                    item: item,
                    quantity: _cart[item.name] ?? 0,
                    onAdd: () => _addToCart(item),
                    onRemove: () => _removeFromCart(item),
                  ),
              ],
            ),
          ),
        ],
      ),
      // Cart bar only shows when something is in the cart
      bottomNavigationBar: _totalItems == 0
          ? null
          : SafeArea(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.dark,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.shopping_basket, color: AppColors.accent),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '$_totalItems item${_totalItems == 1 ? '' : 's'}  |  Rs. $_totalPrice',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _showCheckout,
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.dark,
                      ),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
