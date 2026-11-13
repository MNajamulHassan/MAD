class Restaurant {
  final String name;
  final String cuisine;
  final String area;
  final String emoji;
  final double rating;
  final int deliveryMinutes;

  const Restaurant({
    required this.name,
    required this.cuisine,
    required this.area,
    required this.emoji,
    required this.rating,
    required this.deliveryMinutes,
  });
}

const List<Restaurant> restaurants = [
  Restaurant(
    name: 'Biryani House',
    cuisine: 'Desi',
    area: 'Saddar, Rawalpindi',
    emoji: '🍛',
    rating: 4.7,
    deliveryMinutes: 30,
  ),
  Restaurant(
    name: 'Karahi Corner',
    cuisine: 'Desi',
    area: 'Satellite Town, Rawalpindi',
    emoji: '🥘',
    rating: 4.6,
    deliveryMinutes: 40,
  ),
  Restaurant(
    name: 'Kabab Junction',
    cuisine: 'BBQ',
    area: 'Commercial Market, Rawalpindi',
    emoji: '🍢',
    rating: 4.5,
    deliveryMinutes: 35,
  ),
  Restaurant(
    name: 'Tikka Town',
    cuisine: 'BBQ',
    area: 'Bahria Town Phase 7',
    emoji: '🍗',
    rating: 4.4,
    deliveryMinutes: 45,
  ),
  Restaurant(
    name: 'Cheezy Bites',
    cuisine: 'Fast Food',
    area: 'F-7 Markaz, Islamabad',
    emoji: '🍕',
    rating: 4.3,
    deliveryMinutes: 35,
  ),
  Restaurant(
    name: 'Shawarma Station',
    cuisine: 'Fast Food',
    area: 'Blue Area, Islamabad',
    emoji: '🌯',
    rating: 4.2,
    deliveryMinutes: 25,
  ),
  Restaurant(
    name: 'Crispy Crunch',
    cuisine: 'Fast Food',
    area: 'G-9 Markaz, Islamabad',
    emoji: '🍔',
    rating: 4.4,
    deliveryMinutes: 30,
  ),
  Restaurant(
    name: 'Nihari Wala',
    cuisine: 'Desi',
    area: 'Raja Bazaar, Rawalpindi',
    emoji: '🍲',
    rating: 4.8,
    deliveryMinutes: 50,
  ),
  Restaurant(
    name: 'Chai Khana',
    cuisine: 'Drinks',
    area: 'F-10 Markaz, Islamabad',
    emoji: '☕',
    rating: 4.5,
    deliveryMinutes: 20,
  ),
  Restaurant(
    name: 'Fresh Squeeze',
    cuisine: 'Drinks',
    area: 'DHA Phase 2',
    emoji: '🥤',
    rating: 4.1,
    deliveryMinutes: 25,
  ),
  Restaurant(
    name: 'Sweet Tooth',
    cuisine: 'Desserts',
    area: 'Chandni Chowk, Rawalpindi',
    emoji: '🍰',
    rating: 4.6,
    deliveryMinutes: 30,
  ),
  Restaurant(
    name: 'Mithai Mahal',
    cuisine: 'Desserts',
    area: 'I-8 Markaz, Islamabad',
    emoji: '🍡',
    rating: 4.3,
    deliveryMinutes: 35,
  ),
];
