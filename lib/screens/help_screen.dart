import 'package:flutter/material.dart';

import '../theme.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  static const _faqs = [
    (
      'How long does delivery take?',
      'Most orders reach you in 25 to 35 minutes depending on your area.',
    ),
    (
      'What payment methods are accepted?',
      'Right now we only accept cash on delivery.',
    ),
    (
      'Can I cancel my order?',
      'You can cancel within 2 minutes of placing the order by calling support.',
    ),
    (
      'Is there a delivery fee?',
      'A flat Rs. 99 fee is added to every order.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Frequently asked questions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.dark,
            ),
          ),
          const SizedBox(height: 12),
          for (final faq in _faqs)
            Card(
              color: Colors.white,
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: ExpansionTile(
                shape: const Border(),
                title: Text(
                  faq.$1,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                expandedAlignment: Alignment.centerLeft,
                children: [
                  Text(faq.$2, style: const TextStyle(color: AppColors.muted)),
                ],
              ),
            ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.support_agent, color: AppColors.accent, size: 36),
                SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Still need help?\nCall 0300-0000000 (9am - 11pm)',
                    style: TextStyle(color: Colors.white, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
