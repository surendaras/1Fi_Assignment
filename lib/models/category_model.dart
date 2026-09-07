import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final IconData icon;
  final int itemCount;
  final bool isPopular;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.itemCount,
    this.isPopular = false,
  });
}
