import 'package:flutter/material.dart';

import 'routes.dart';
import 'theme.dart';

void main() {
  runApp(const FoodieExpressApp());
}

class FoodieExpressApp extends StatelessWidget {
  const FoodieExpressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodie Express',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
