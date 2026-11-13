class FoodItem {
  final String name;
  final String description;
  final String category;
  final String emoji;
  final int price; // in rupees
  final double rating;
  final bool isPopular;

  const FoodItem({
    required this.name,
    required this.description,
    required this.category,
    required this.emoji,
    required this.price,
    this.rating = 4.3,
    this.isPopular = false,
  });
}

const List<String> foodCategories = [
  'All',
  'Desi',
  'Fast Food',
  'BBQ',
  'Drinks',
  'Desserts',
];

const List<FoodItem> menuItems = [
  // Desi
  FoodItem(
    name: 'Chicken Biryani',
    description: 'Spicy rice layered with tender chicken',
    category: 'Desi',
    emoji: '🍛',
    price: 450,
    rating: 4.8,
    isPopular: true,
  ),
  FoodItem(
    name: 'Chicken Karahi',
    description: 'Half kg karahi cooked in tomatoes & ginger',
    category: 'Desi',
    emoji: '🥘',
    price: 1200,
    rating: 4.7,
    isPopular: true,
  ),
  FoodItem(
    name: 'Daal Chawal',
    description: 'Yellow lentils with steamed basmati rice',
    category: 'Desi',
    emoji: '🍚',
    price: 300,
    rating: 4.2,
  ),
  FoodItem(
    name: 'Nihari',
    description: 'Slow cooked beef stew with naan',
    category: 'Desi',
    emoji: '🍲',
    price: 650,
    rating: 4.6,
  ),
  // Fast Food
  FoodItem(
    name: 'Zinger Burger',
    description: 'Crispy chicken fillet with mayo & lettuce',
    category: 'Fast Food',
    emoji: '🍔',
    price: 550,
    rating: 4.5,
    isPopular: true,
  ),
  FoodItem(
    name: 'Fajita Pizza',
    description: 'Medium pizza with chicken fajita topping',
    category: 'Fast Food',
    emoji: '🍕',
    price: 1100,
    rating: 4.4,
  ),
  FoodItem(
    name: 'Loaded Fries',
    description: 'Fries with cheese sauce and jalapenos',
    category: 'Fast Food',
    emoji: '🍟',
    price: 380,
    rating: 4.1,
  ),
  FoodItem(
    name: 'Chicken Shawarma',
    description: 'Wrapped in pita with garlic sauce',
    category: 'Fast Food',
    emoji: '🌯',
    price: 320,
    rating: 4.3,
  ),
  FoodItem(
    name: 'Club Sandwich',
    description: 'Triple layer with chicken, egg and fries',
    category: 'Fast Food',
    emoji: '🥪',
    price: 480,
    rating: 4.0,
  ),
  // BBQ
  FoodItem(
    name: 'Seekh Kabab',
    description: '4 charcoal grilled beef kababs',
    category: 'BBQ',
    emoji: '🍢',
    price: 520,
    rating: 4.6,
    isPopular: true,
  ),
  FoodItem(
    name: 'Chicken Tikka',
    description: 'Leg piece marinated in tikka masala',
    category: 'BBQ',
    emoji: '🍗',
    price: 420,
    rating: 4.5,
  ),
  FoodItem(
    name: 'Malai Boti',
    description: 'Creamy boneless chicken cubes',
    category: 'BBQ',
    emoji: '🥩',
    price: 690,
    rating: 4.7,
  ),
  FoodItem(
    name: 'Chapli Kabab',
    description: 'Peshawari style with tomato & onion',
    category: 'BBQ',
    emoji: '🧆',
    price: 380,
    rating: 4.4,
  ),
  // Drinks
  FoodItem(
    name: 'Mango Lassi',
    description: 'Chilled yogurt drink with mango pulp',
    category: 'Drinks',
    emoji: '🥭',
    price: 250,
    rating: 4.6,
    isPopular: true,
  ),
  FoodItem(
    name: 'Mint Margarita',
    description: 'Fresh mint, lemon and soda',
    category: 'Drinks',
    emoji: '🍹',
    price: 220,
    rating: 4.3,
  ),
  FoodItem(
    name: 'Doodh Patti',
    description: 'Strong tea boiled in milk',
    category: 'Drinks',
    emoji: '☕',
    price: 120,
    rating: 4.5,
  ),
  FoodItem(
    name: 'Fresh Lime Soda',
    description: 'Sweet or salty, your choice',
    category: 'Drinks',
    emoji: '🍋',
    price: 150,
    rating: 4.0,
  ),
  // Desserts
  FoodItem(
    name: 'Gulab Jamun',
    description: '3 pieces soaked in warm syrup',
    category: 'Desserts',
    emoji: '🍡',
    price: 200,
    rating: 4.5,
  ),
  FoodItem(
    name: 'Kheer',
    description: 'Creamy rice pudding with pistachios',
    category: 'Desserts',
    emoji: '🍮',
    price: 230,
    rating: 4.4,
  ),
  FoodItem(
    name: 'Chocolate Lava Cake',
    description: 'Warm cake with a melting centre',
    category: 'Desserts',
    emoji: '🍫',
    price: 390,
    rating: 4.7,
    isPopular: true,
  ),
];
