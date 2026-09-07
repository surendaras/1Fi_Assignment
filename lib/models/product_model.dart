import 'variant_model.dart';

class ProductModel {
  final String id;
  final String title;
  final String subtitle;
  final String brand;
  final String categoryId;
  final double basePrice; // Original MRP
  final double discountedPrice; // Current 1Fi Offer Price
  final double rating;
  final int reviewCount;
  final List<String> images;
  final List<ColorVariant> colors;
  final List<StorageVariant> storageOptions;
  final List<String> highlights;
  final Map<String, String> specifications;
  final bool inStock;
  final bool isTrending;
  final bool hasNoCostEmi;
  final double cashbackAmount;
  final String warrantyInfo;
  final String returnPolicy;

  const ProductModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.brand,
    required this.categoryId,
    required this.basePrice,
    required this.discountedPrice,
    required this.rating,
    required this.reviewCount,
    required this.images,
    required this.colors,
    required this.storageOptions,
    required this.highlights,
    required this.specifications,
    this.inStock = true,
    this.isTrending = false,
    this.hasNoCostEmi = true,
    this.cashbackAmount = 0.0,
    this.warrantyInfo = '1 Year Manufacturer Brand Warranty',
    this.returnPolicy = '7 Days Replacement Guarantee',
  });

  int get discountPercentage {
    if (basePrice <= 0 || discountedPrice >= basePrice) return 0;
    return (((basePrice - discountedPrice) / basePrice) * 100).round();
  }

  double get startingEmiPerMonth {
    // 6 Months No Cost EMI starting price
    return (discountedPrice / 6);
  }

  ProductModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? brand,
    String? categoryId,
    double? basePrice,
    double? discountedPrice,
    double? rating,
    int? reviewCount,
    List<String>? images,
    List<ColorVariant>? colors,
    List<StorageVariant>? storageOptions,
    List<String>? highlights,
    Map<String, String>? specifications,
    bool? inStock,
    bool? isTrending,
    bool? hasNoCostEmi,
    double? cashbackAmount,
    String? warrantyInfo,
    String? returnPolicy,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      brand: brand ?? this.brand,
      categoryId: categoryId ?? this.categoryId,
      basePrice: basePrice ?? this.basePrice,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      images: images ?? this.images,
      colors: colors ?? this.colors,
      storageOptions: storageOptions ?? this.storageOptions,
      highlights: highlights ?? this.highlights,
      specifications: specifications ?? this.specifications,
      inStock: inStock ?? this.inStock,
      isTrending: isTrending ?? this.isTrending,
      hasNoCostEmi: hasNoCostEmi ?? this.hasNoCostEmi,
      cashbackAmount: cashbackAmount ?? this.cashbackAmount,
      warrantyInfo: warrantyInfo ?? this.warrantyInfo,
      returnPolicy: returnPolicy ?? this.returnPolicy,
    );
  }
}
