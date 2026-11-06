import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../routes.dart';
import '../theme.dart';
import '../widgets/food_card.dart';

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
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  /// Opens the detail page and waits for the quantity it returns.
  Future<void> _openDetail(FoodItem item) async {
    final quantity = await Navigator.pushNamed<int>(
      context,
      AppRoutes.foodDetail,
      arguments: item,
    );
    if (quantity == null || !mounted) return;

    setState(() {
      _cart[item.name] = (_cart[item.name] ?? 0) + quantity;
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('Added $quantity x ${item.name} to cart')),
      );
  }

  void _showCheckout() {
    if (_cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your cart is empty. Add some food first!')),
      );
      return;
    }

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

  Widget _navItem(IconData icon, String label, String? route,
      {bool selected = false}) {
    final color = selected ? AppColors.accent : Colors.white70;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: route == null ? null : () => Navigator.pushNamed(context, route),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            Text(label, style: TextStyle(color: color, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AppColors.background,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
            color: AppColors.primary,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.accent,
                  child: Text(
                    widget.userName[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.dark,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Foodie Express member',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _drawerTile(Icons.restaurant_menu, 'Menu', null),
          _drawerTile(Icons.person_outline, 'My Profile', AppRoutes.profile),
          _drawerTile(Icons.help_outline, 'Help & Support', AppRoutes.help),
          _drawerTile(Icons.info_outline, 'About', AppRoutes.about),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Log out'),
            onTap: _logout,
          ),
        ],
      ),
    );
  }

  Widget _drawerTile(IconData icon, String title, String? route) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      onTap: () {
        Navigator.pop(context); // close the drawer first
        if (route != null) Navigator.pushNamed(context, route);
      },
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
                    onTap: () => _openDetail(item),
                  ),
              ],
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      // Cart button sits in the notch of the BottomAppBar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _showCheckout,
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.dark,
        shape: const CircleBorder(),
        child: Badge(
          isLabelVisible: _totalItems > 0,
          label: Text('$_totalItems'),
          child: const Icon(Icons.shopping_basket),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: AppColors.primary,
        height: 68,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home_rounded, 'Home', null, selected: true),
            _navItem(Icons.help_outline, 'Help', AppRoutes.help),
            const SizedBox(width: 48), // space for the cart button
            _navItem(Icons.info_outline, 'About', AppRoutes.about),
            _navItem(Icons.person_outline, 'Profile', AppRoutes.profile),
          ],
        ),
      ),
    );
  }
}
