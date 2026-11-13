import 'package:flutter/material.dart';

import '../theme.dart';

/// Keeps the category chips stuck to the top while the menu scrolls
/// underneath (used with SliverPersistentHeader, pinned: true).
class CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final List<String> categories;
  final String selected;
  final ValueChanged<String> onSelected;

  CategoryHeaderDelegate({
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  static const double _height = 60;

  @override
  double get minExtent => _height;

  @override
  double get maxExtent => _height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppColors.background,
      alignment: Alignment.center,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          return Center(
            child: ChoiceChip(
              label: Text(category),
              selected: selected == category,
              onSelected: (_) => onSelected(category),
              selectedColor: AppColors.accent,
              backgroundColor: Colors.white,
              showCheckmark: false,
              side: BorderSide.none,
              shape: const StadiumBorder(),
            ),
          );
        },
      ),
    );
  }

  // Rebuild when the selected chip changes
  @override
  bool shouldRebuild(covariant CategoryHeaderDelegate oldDelegate) {
    return oldDelegate.selected != selected;
  }
}
