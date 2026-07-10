import 'package:flutter/material.dart';

class CategoryItemData {
  final String label;
  final IconData icon;

  const CategoryItemData({required this.label, required this.icon});
}

class CategoryCatalog {
  CategoryCatalog._();

  static const List<CategoryItemData> all = [
    CategoryItemData(label: 'Fashion', icon: Icons.checkroom_outlined),
    CategoryItemData(label: 'Electronics', icon: Icons.devices_outlined),
    CategoryItemData(label: 'Home', icon: Icons.chair_outlined),
    CategoryItemData(label: 'Beauty', icon: Icons.spa_outlined),
    CategoryItemData(label: 'Luxury', icon: Icons.watch_outlined),
    CategoryItemData(label: 'Gaming', icon: Icons.sports_esports_outlined),
  ];
}