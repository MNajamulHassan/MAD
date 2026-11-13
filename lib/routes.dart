import 'package:flutter/material.dart';

import 'models/food_item.dart';
import 'screens/about_screen.dart';
import 'screens/cuisines_screen.dart';
import 'screens/food_detail_screen.dart';
import 'screens/help_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/restaurants_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';

/// All route names in one place so we don't mistype strings.
class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const welcome = '/welcome';
  static const home = '/home';
  static const foodDetail = '/food';
  static const help = '/help';
  static const about = '/about';
  static const profile = '/profile';
  static const restaurants = '/restaurants';
  static const cuisines = '/cuisines';

  /// Builds the page for a route name. Routes that need data
  /// (user name or a food item) read it from settings.arguments.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    Widget page;

    switch (settings.name) {
      case splash:
        page = const SplashScreen();
        break;
      case login:
        page = const LoginScreen();
        break;
      case signup:
        page = const SignupScreen();
        break;
      case welcome:
        page = WelcomeScreen(userName: args as String? ?? 'Foodie');
        break;
      case home:
        page = HomeScreen(userName: args as String? ?? 'Foodie');
        break;
      case foodDetail:
        page = FoodDetailScreen(item: args as FoodItem);
        break;
      case help:
        page = const HelpScreen();
        break;
      case about:
        page = const AboutScreen();
        break;
      case profile:
        page = const ProfileScreen();
        break;
      case restaurants:
        page = const RestaurantsScreen();
        break;
      case cuisines:
        page = const CuisinesScreen();
        break;
      default:
        page = const _NotFoundScreen();
    }

    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('Page not found')),
    );
  }
}
