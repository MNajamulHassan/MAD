import 'package:flutter/material.dart';

import '../theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delivery_dining,
                  size: 64,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Foodie Express',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.dark,
                ),
              ),
              const Text('Version 1.0.0', style: TextStyle(color: AppColors.muted)),
              const SizedBox(height: 20),
              const Text(
                'Order desi food, fast food, drinks and desserts from '
                'restaurants near you and get it delivered hot to your door.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, height: 1.5),
              ),
              const SizedBox(height: 28),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.person, color: AppColors.primary),
                title: Text('Developed by'),
                subtitle: Text('M. Najam-ul-Hassan'),
              ),
              const ListTile(
                leading: Icon(Icons.school, color: AppColors.primary),
                title: Text('Course'),
                subtitle: Text('Mobile Application Development, Riphah'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
