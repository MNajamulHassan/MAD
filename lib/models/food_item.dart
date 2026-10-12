class FoodItem {
  final String name;
  final String description;
  final String category;
  final String emoji;
  final int price; // in rupees

  const FoodItem({
    required this.name,
    required this.description,
    required this.category,
    required this.emoji,
    required this.price,
  });
}

const List<String> foodCategories = [
  'All',
  'Desi',
  'Fast Food',
  'Drinks',
  'Desserts',
];

const List<FoodItem> menuItems = [
  FoodItem(
    name: 'Chicken Biryani',
    description: 'Spicy rice layered with tender chicken',
    category: 'Desi',
    emoji: '🍛',
    price: 450,
  ),
  FoodItem(
    name: 'Chicken Karahi',
    description: 'Half kg karahi cooked in tomatoes & ginger',
    category: 'Desi',
    emoji: '🥘',
    price: 1200,
  ),
  FoodItem(
    name: 'Seekh Kabab',
    description: '4 charcoal grilled beef kababs',
    category: 'Desi',
    emoji: '🍢',
    price: 520,
  ),
  FoodItem(
    name: 'Zinger Burger',
    description: 'Crispy chicken fillet with mayo & lettuce',
    category: 'Fast Food',
    emoji: '🍔',
    price: 550,
  ),
  FoodItem(
    name: 'Fajita Pizza',
    description: 'Medium pizza with chicken fajita topping',
    category: 'Fast Food',
    emoji: '🍕',
    price: 1100,
  ),
  FoodItem(
    name: 'Loaded Fries',
    description: 'Fries with cheese sauce and jalapenos',
    category: 'Fast Food',
    emoji: '🍟',
    price: 380,
  ),
  FoodItem(
    name: 'Mango Lassi',
    description: 'Chilled yogurt drink with mango pulp',
    category: 'Drinks',
    emoji: '🥭',
    price: 250,
  ),
  FoodItem(
    name: 'Mint Margarita',
    description: 'Fresh mint, lemon and soda',
    category: 'Drinks',
    emoji: '🍹',
    price: 220,
  ),
  FoodItem(
    name: 'Gulab Jamun',
    description: '3 pieces soaked in warm syrup',
    category: 'Desserts',
    emoji: '🍡',
    price: 200,
  ),
  FoodItem(
    name: 'Kheer',
    description: 'Creamy rice pudding with pistachios',
    category: 'Desserts',
    emoji: '🍮',
    price: 230,
  ),
];
