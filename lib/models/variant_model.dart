import 'package:flutter/material.dart';

class ColorVariant {
  final String id;
  final String name;
  final Color colorCode;
  final String? imageUrl;

  const ColorVariant({
    required this.id,
    required this.name,
    required this.colorCode,
    this.imageUrl,
  });
}

class StorageVariant {
  final String id;
  final String label; // e.g. "128 GB", "256 GB", "512 GB", "1 TB" or "8GB/256GB"
  final double priceDelta; // Difference from base price (can be 0 or positive)

  const StorageVariant({
    required this.id,
    required this.label,
    this.priceDelta = 0.0,
  });
}
