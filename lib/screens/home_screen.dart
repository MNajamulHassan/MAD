import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../models/restaurant.dart';
import '../routes.dart';
import '../theme.dart';
import '../widgets/category_header_delegate.dart';
import '../widgets/food_card.dart';
import '../widgets/food_grid_card.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  bool _showGrid = true;

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

  /// Opens the cuisines grid and filters the menu by the one picked.
  Future<void> _openCuisines() async {
    final category = await Navigator.pushNamed<String>(
      context,
      AppRoutes.cuisines,
    );
    if (category == null || !mounted) return;
    setState(() => _selectedCategory = category);
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
          _drawerTile(Icons.storefront_outlined, 'Restaurants', AppRoutes.restaurants),
          ListTile(
            leading: const Icon(Icons.grid_view_rounded, color: AppColors.primary),
            title: const Text('Cuisines'),
            onTap: () {
              Navigator.pop(context); // close the drawer first
              _openCuisines();
            },
          ),
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

  Widget _shortcutCard(
    String emoji,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.dark,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.dark,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _visibleItems;
    final popularItems = menuItems.where((item) => item.isPopular).toList();

    return Scaffold(
      // CustomScrollView lets different scrolling pieces (slivers)
      // scroll together as one page.
      body: CustomScrollView(
        slivers: [
          // 1. Big green header that collapses into a normal app bar
          SliverAppBar(
            pinned: true,
            expandedHeight: 220,
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            title: Text(
              'Hi, ${widget.userName} 👋',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 60, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 16, color: AppColors.accent),
                          SizedBox(width: 4),
                          Text(
                            'Deliver to: Rawalpindi',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(18),
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
                                    'On your first order above Rs. 1500',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text('🛵', style: TextStyle(fontSize: 40)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Shortcuts to the Restaurants (ListView) and Cuisines (GridView) screens
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Row(
                children: [
                  Expanded(
                    child: _shortcutCard(
                      '🏪',
                      'Restaurants',
                      '${restaurants.length} near you',
                      () => Navigator.pushNamed(context, AppRoutes.restaurants),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _shortcutCard(
                      '🍽️',
                      'Cuisines',
                      'Pick a craving',
                      _openCuisines,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Category chips that stay pinned under the app bar
          SliverPersistentHeader(
            pinned: true,
            delegate: CategoryHeaderDelegate(
              categories: foodCategories,
              selected: _selectedCategory,
              onSelected: (category) {
                setState(() => _selectedCategory = category);
              },
            ),
          ),

          // 3. Horizontal "Popular" row (only on the All tab)
          if (_selectedCategory == 'All') ...[
            _sectionTitle('Popular near you 🔥'),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 230,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: popularItems.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    final item = popularItems[index];
                    return SizedBox(
                      width: 160,
                      child: FoodGridCard(
                        item: item,
                        heroTag: 'popular-${item.name}',
                        quantity: _cart[item.name] ?? 0,
                        onAdd: () => _addToCart(item),
                        onTap: () => _openDetail(item),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],

          // 4. Title row with grid/list toggle
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 12, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedCategory == 'All'
                          ? 'All dishes (${items.length})'
                          : '$_selectedCategory (${items.length})',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.dark,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: _showGrid ? 'Show as list' : 'Show as grid',
                    onPressed: () => setState(() => _showGrid = !_showGrid),
                    icon: Icon(
                      _showGrid ? Icons.view_list_rounded : Icons.grid_view_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 5. The dishes, as a grid or a list. Builder delegates only
          // build the cards that are on screen.
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            sliver: _showGrid
                ? SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      mainAxisExtent: 230,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = items[index];
                        return FoodGridCard(
                          item: item,
                          quantity: _cart[item.name] ?? 0,
                          onAdd: () => _addToCart(item),
                          onTap: () => _openDetail(item),
                        );
                      },
                      childCount: items.length,
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = items[index];
                        return FoodCard(
                          item: item,
                          quantity: _cart[item.name] ?? 0,
                          onAdd: () => _addToCart(item),
                          onRemove: () => _removeFromCart(item),
                          onTap: () => _openDetail(item),
                        );
                      },
                      childCount: items.length,
                    ),
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
