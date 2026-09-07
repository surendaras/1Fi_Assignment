import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';
import '../models/variant_model.dart';
import 'product_repository.dart';

class MockProductRepository implements ProductRepository {
  // Mock Category Database
  final List<CategoryModel> _categories = [
    const CategoryModel(
      id: 'all',
      name: 'All Products',
      icon: Icons.grid_view_rounded,
      itemCount: 16,
      isPopular: true,
    ),
    const CategoryModel(
      id: 'smartphones',
      name: 'Smartphones',
      icon: Icons.phone_iphone_rounded,
      itemCount: 5,
      isPopular: true,
    ),
    const CategoryModel(
      id: 'laptops',
      name: 'Laptops & PC',
      icon: Icons.laptop_mac_rounded,
      itemCount: 4,
      isPopular: true,
    ),
    const CategoryModel(
      id: 'audio',
      name: 'Audio & Sound',
      icon: Icons.headphones_rounded,
      itemCount: 3,
      isPopular: false,
    ),
    const CategoryModel(
      id: 'wearables',
      name: 'Wearables',
      icon: Icons.watch_rounded,
      itemCount: 2,
      isPopular: false,
    ),
    const CategoryModel(
      id: 'appliances',
      name: 'Smart Home',
      icon: Icons.home_rounded,
      itemCount: 2,
      isPopular: false,
    ),
  ];

  // Mock Products Database with high quality images and realistic specs
  final List<ProductModel> _products = [
    // 1. iPhone 16 Pro Max
    ProductModel(
      id: 'prod-001',
      title: 'Apple iPhone 16 Pro Max',
      subtitle: 'Titanium Design • A18 Pro Chip • 48MP Camera',
      brand: 'Apple',
      categoryId: 'smartphones',
      basePrice: 144900.0,
      discountedPrice: 134999.0,
      rating: 4.9,
      reviewCount: 2840,
      isTrending: true,
      hasNoCostEmi: true,
      cashbackAmount: 5000.0,
      images: [
        'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=800&q=80',
        'https://images.unsplash.com/photo-1591337676887-a217a6970a8a?w=800&q=80',
        'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?w=800&q=80',
      ],
      colors: const [
        ColorVariant(id: 'c1', name: 'Desert Titanium', colorCode: Color(0xFFC3B091)),
        ColorVariant(id: 'c2', name: 'Natural Titanium', colorCode: Color(0xFF9E9A96)),
        ColorVariant(id: 'c3', name: 'White Titanium', colorCode: Color(0xFFF2F2F2)),
        ColorVariant(id: 'c4', name: 'Black Titanium', colorCode: Color(0xFF2E2E2E)),
      ],
      storageOptions: const [
        StorageVariant(id: 's1', label: '256 GB', priceDelta: 0.0),
        StorageVariant(id: 's2', label: '512 GB', priceDelta: 20000.0),
        StorageVariant(id: 's3', label: '1 TB', priceDelta: 40000.0),
      ],
      highlights: [
        '6.9" Super Retina XDR display with ProMotion 120Hz',
        'Grade 5 Titanium frame with micro-blasted finish',
        'Next-gen Camera Control button with tactile haptics',
        '48MP Fusion Camera with 5x Telephoto Optical Zoom',
        'Up to 33 hours video playback battery life',
        '1Fi Instant Credit: 0% downpayment on 6-month tenure',
      ],
      specifications: {
        'Processor': 'Apple A18 Pro (3nm architecture)',
        'Display': '6.9-inch OLED (2868 x 1320 px, 120Hz)',
        'Rear Camera': '48MP Main + 48MP Ultra-Wide + 12MP 5x Telephoto',
        'Front Camera': '12MP TrueDepth with autofocus',
        'Operating System': 'iOS 18 with Apple Intelligence',
        'Weight': '227 grams',
        'Water Resistance': 'IP68 (6m up to 30 mins)',
      },
    ),

    // 2. Samsung Galaxy S25 Ultra
    ProductModel(
      id: 'prod-002',
      title: 'Samsung Galaxy S25 Ultra 5G',
      subtitle: 'Snapdragon 8 Elite • 200MP AI Zoom • Built-in S-Pen',
      brand: 'Samsung',
      categoryId: 'smartphones',
      basePrice: 134999.0,
      discountedPrice: 124999.0,
      rating: 4.8,
      reviewCount: 1950,
      isTrending: true,
      hasNoCostEmi: true,
      cashbackAmount: 4000.0,
      images: [
        'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=800&q=80',
        'https://images.unsplash.com/photo-1580910051074-3eb694886505?w=800&q=80',
      ],
      colors: const [
        ColorVariant(id: 'c1', name: 'Titanium Gray', colorCode: Color(0xFF75787B)),
        ColorVariant(id: 'c2', name: 'Titanium Black', colorCode: Color(0xFF1E1E1E)),
        ColorVariant(id: 'c3', name: 'Titanium Blue', colorCode: Color(0xFF4A6984)),
      ],
      storageOptions: const [
        StorageVariant(id: 's1', label: '12GB / 256GB', priceDelta: 0.0),
        StorageVariant(id: 's2', label: '12GB / 512GB', priceDelta: 15000.0),
        StorageVariant(id: 's3', label: '16GB / 1TB', priceDelta: 35000.0),
      ],
      highlights: [
        '6.8" Dynamic AMOLED 2X flat display with Anti-reflective Corning Armor',
        'Snapdragon 8 Elite for Galaxy with massive cooling chamber',
        'Galaxy AI: Circle to Search, Live Call Translate, Note Assist',
        'Integrated Bluetooth S-Pen stylus included in chassis',
      ],
      specifications: {
        'Processor': 'Qualcomm Snapdragon 8 Elite (4.47 GHz)',
        'Display': '6.8-inch QHD+ Dynamic AMOLED 2X, 1-120Hz',
        'Camera': '200MP + 50MP 5x + 50MP 3x + 50MP Ultra-Wide',
        'Battery': '5000 mAh with 45W fast charge',
        'OS': 'Android 15 with One UI 7',
      },
    ),

    // 3. MacBook Pro 14" M3 Pro
    ProductModel(
      id: 'prod-003',
      title: 'Apple MacBook Pro 14" (M3 Pro)',
      subtitle: '18GB Unified Memory • 512GB SSD • Space Black',
      brand: 'Apple',
      categoryId: 'laptops',
      basePrice: 199900.0,
      discountedPrice: 179900.0,
      rating: 4.9,
      reviewCount: 890,
      isTrending: true,
      hasNoCostEmi: true,
      cashbackAmount: 8000.0,
      images: [
        'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800&q=80',
        'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=800&q=80',
      ],
      colors: const [
        ColorVariant(id: 'c1', name: 'Space Black', colorCode: Color(0xFF202124)),
        ColorVariant(id: 'c2', name: 'Silver', colorCode: Color(0xFFE3E4E5)),
      ],
      storageOptions: const [
        StorageVariant(id: 's1', label: '18GB / 512GB', priceDelta: 0.0),
        StorageVariant(id: 's2', label: '18GB / 1TB', priceDelta: 20000.0),
        StorageVariant(id: 's3', label: '36GB / 1TB', priceDelta: 60000.0),
      ],
      highlights: [
        'Liquid Retina XDR display with 1600 nits peak HDR brightness',
        'Apple M3 Pro chip with 11-core CPU and 14-core GPU',
        'Up to 18 hours battery life with MagSafe 3 charging',
        'Full array of ports: HDMI, SDXC card slot, 3x Thunderbolt 4',
      ],
      specifications: {
        'Chip': 'Apple M3 Pro (11 CPU, 14 GPU)',
        'Unified Memory': '18GB unified memory',
        'Storage': '512GB ultra-fast NVMe SSD',
        'Display': '14.2" Liquid Retina XDR (3024x1964)',
        'Weight': '1.61 kg',
      },
    ),

    // 4. Sony WH-1000XM5 Wireless Headphones
    ProductModel(
      id: 'prod-004',
      title: 'Sony WH-1000XM5 Noise Cancelling',
      subtitle: 'Industry Leading Active Noise Canceling • 30 Hr Battery',
      brand: 'Sony',
      categoryId: 'audio',
      basePrice: 34990.0,
      discountedPrice: 26990.0,
      rating: 4.7,
      reviewCount: 3410,
      isTrending: true,
      hasNoCostEmi: true,
      cashbackAmount: 1500.0,
      images: [
        'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=800&q=80',
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800&q=80',
      ],
      colors: const [
        ColorVariant(id: 'c1', name: 'Black', colorCode: Color(0xFF1F1F1F)),
        ColorVariant(id: 'c2', name: 'Silver / Cream', colorCode: Color(0xFFE6E3DE)),
        ColorVariant(id: 'c3', name: 'Midnight Blue', colorCode: Color(0xFF1D2951)),
      ],
      storageOptions: const [
        StorageVariant(id: 's1', label: 'Standard Edition', priceDelta: 0.0),
      ],
      highlights: [
        'Dual processors and 8 microphones for unrivaled noise cancellation',
        'Ultra-comfortable lightweight design with soft fit leather',
        'Multipoint connection allows pairing with two devices simultaneously',
        'Speak-to-chat technology automatically pauses music when you talk',
      ],
      specifications: {
        'Battery Life': 'Up to 30 hours (ANC on)',
        'Quick Charge': '3 min charge gives 3 hours playback',
        'Driver Unit': '30mm carbon fiber composite',
        'Bluetooth': 'v5.2 with LDAC, AAC, SBC codec support',
        'Weight': '250 grams',
      },
    ),

    // 5. Apple Watch Ultra 2
    ProductModel(
      id: 'prod-005',
      title: 'Apple Watch Ultra 2 (GPS + Cellular)',
      subtitle: '49mm Rugged Titanium • 3000 nits Display • Dual GPS',
      brand: 'Apple',
      categoryId: 'wearables',
      basePrice: 89900.0,
      discountedPrice: 82900.0,
      rating: 4.9,
      reviewCount: 1120,
      isTrending: false,
      hasNoCostEmi: true,
      cashbackAmount: 3000.0,
      images: [
        'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=800&q=80',
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800&q=80',
      ],
      colors: const [
        ColorVariant(id: 'c1', name: 'Natural Titanium', colorCode: Color(0xFFB5B0AA)),
        ColorVariant(id: 'c2', name: 'Black Titanium', colorCode: Color(0xFF222326)),
      ],
      storageOptions: const [
        StorageVariant(id: 's1', label: 'Ocean Band', priceDelta: 0.0),
        StorageVariant(id: 's2', label: 'Trail Loop', priceDelta: 0.0),
        StorageVariant(id: 's3', label: 'Alpine Loop', priceDelta: 0.0),
      ],
      highlights: [
        'Corrosion-resistant 49mm aerospace titanium case',
        'Brightest Apple display ever with 3000 nits peak brightness',
        'Precision dual-frequency GPS for route accuracy',
        'Water resistant to 100m with depth gauge and water temperature sensor',
      ],
      specifications: {
        'Case Size': '49mm Titanium',
        'Battery Life': 'Up to 36 hours (72 hrs low power mode)',
        'Display': 'Always-On Retina OLED sapphire front crystal',
        'Sensors': 'ECG, Blood Oxygen, Depth Gauge, Temperature',
      },
    ),

    // 6. Asus ROG Zephyrus G16
    ProductModel(
      id: 'prod-006',
      title: 'ASUS ROG Zephyrus G16 Gaming Laptop',
      subtitle: 'Intel Core Ultra 9 • RTX 4080 12GB • 2.5K 240Hz OLED',
      brand: 'Asus',
      categoryId: 'laptops',
      basePrice: 229990.0,
      discountedPrice: 204990.0,
      rating: 4.8,
      reviewCount: 460,
      isTrending: true,
      hasNoCostEmi: true,
      cashbackAmount: 7000.0,
      images: [
        'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=800&q=80',
        'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=800&q=80',
      ],
      colors: const [
        ColorVariant(id: 'c1', name: 'Eclipse Gray', colorCode: Color(0xFF3B3C3D)),
        ColorVariant(id: 'c2', name: 'Platinum White', colorCode: Color(0xFFECEFF1)),
      ],
      storageOptions: const [
        StorageVariant(id: 's1', label: '32GB / 1TB SSD', priceDelta: 0.0),
        StorageVariant(id: 's2', label: '32GB / 2TB SSD', priceDelta: 15000.0),
      ],
      highlights: [
        'Ultra-slim CNC aluminum chassis with Slash Lighting matrix',
        'ROG Nebula 2.5K OLED 240Hz 0.2ms response time display',
        'NVIDIA GeForce RTX 4080 GPU with MUX Switch & NVIDIA Advanced Optimus',
      ],
      specifications: {
        'Processor': 'Intel Core Ultra 9 185H with AI Boost NPU',
        'Graphics': 'NVIDIA GeForce RTX 4080 12GB GDDR6',
        'RAM': '32GB LPDDR5X-7467 MHz',
        'Display': '16.0" 2.5K (2560 x 1600) OLED 240Hz',
        'Weight': '1.85 kg',
      },
    ),

    // 7. Dyson V15 Detect Cordless Vacuum
    ProductModel(
      id: 'prod-007',
      title: 'Dyson V15 Detect Absolute Smart Vacuum',
      subtitle: 'Laser Slim Fluffy • Piezo Sensor • 240 AW Suction',
      brand: 'Dyson',
      categoryId: 'appliances',
      basePrice: 65900.0,
      discountedPrice: 54900.0,
      rating: 4.9,
      reviewCount: 820,
      isTrending: false,
      hasNoCostEmi: true,
      cashbackAmount: 2000.0,
      images: [
        'https://images.unsplash.com/photo-1558317374-067fb5f30001?w=800&q=80',
      ],
      colors: const [
        ColorVariant(id: 'c1', name: 'Yellow / Nickel', colorCode: Color(0xFFFFD54F)),
      ],
      storageOptions: const [
        StorageVariant(id: 's1', label: 'Absolute Edition (6 Tools)', priceDelta: 0.0),
        StorageVariant(id: 's2', label: 'Complete Extra (8 Tools)', priceDelta: 6000.0),
      ],
      highlights: [
        'Laser reveals microscopic dust invisible to naked eye',
        'Piezo sensor counts and measures dust particles in real-time',
        'Intelligently adapts suction power based on floor type and dirt levels',
        'Up to 60 minutes of fade-free runtime with swappable battery',
      ],
      specifications: {
        'Suction Power': '240 Air Watts',
        'Bin Volume': '0.77 Litres',
        'Run Time': '60 Minutes',
        'Filtration': 'Whole-machine HEPA filtration (99.99% of 0.3 microns)',
        'Weight': '3.0 kg',
      },
    ),

    // 8. OnePlus 13 5G
    ProductModel(
      id: 'prod-008',
      title: 'OnePlus 13 5G (Hasselblad Camera)',
      subtitle: 'Snapdragon 8 Elite • 6000mAh Battery • 100W SuperVOOC',
      brand: 'OnePlus',
      categoryId: 'smartphones',
      basePrice: 69999.0,
      discountedPrice: 62999.0,
      rating: 4.7,
      reviewCount: 1680,
      isTrending: true,
      hasNoCostEmi: true,
      cashbackAmount: 2500.0,
      images: [
        'https://images.unsplash.com/photo-1565849904461-04a58ad377e0?w=800&q=80',
        'https://images.unsplash.com/photo-1580910051074-3eb694886505?w=800&q=80',
      ],
      colors: const [
        ColorVariant(id: 'c1', name: 'Emerald Green', colorCode: Color(0xFF2E6B4F)),
        ColorVariant(id: 'c2', name: 'Obsidian Black', colorCode: Color(0xFF1B1B1B)),
        ColorVariant(id: 'c3', name: 'Arctic Blue', colorCode: Color(0xFF64B5F6)),
      ],
      storageOptions: const [
        StorageVariant(id: 's1', label: '12GB / 256GB', priceDelta: 0.0),
        StorageVariant(id: 's2', label: '16GB / 512GB', priceDelta: 7000.0),
      ],
      highlights: [
        '2K 120Hz Oriental Display with DisplayMate A++ rating',
        'Triple 50MP Hasselblad camera system with 3x periscope telephoto',
        'Massive 6000mAh Glacier battery with 100W wired & 50W wireless charging',
        'IP68 and IP69 water and dust resistance rating',
      ],
      specifications: {
        'Processor': 'Qualcomm Snapdragon 8 Elite',
        'Display': '6.82" 2K LTPO 4.0 AMOLED, 1-120Hz',
        'Charging': '100W SuperVOOC (0 to 100% in 28 mins)',
        'OS': 'OxygenOS 15 based on Android 15',
      },
    ),
  ];

  @override
  Future<List<ProductModel>> getProducts({
    String? categoryId,
    String? searchQuery,
    double? minPrice,
    double? maxPrice,
    String? brand,
    bool? noCostEmiOnly,
    String? sortBy,
  }) async {
    // Simulate realistic API latency
    await Future.delayed(const Duration(milliseconds: 200));

    var list = List<ProductModel>.from(_products);

    if (categoryId != null && categoryId != 'all') {
      list = list.where((p) => p.categoryId == categoryId).toList();
    }

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      final query = searchQuery.trim().toLowerCase();
      list = list.where((p) {
        return p.title.toLowerCase().contains(query) ||
            p.brand.toLowerCase().contains(query) ||
            p.subtitle.toLowerCase().contains(query);
      }).toList();
    }

    if (brand != null && brand.isNotEmpty && brand != 'All Brands') {
      list = list.where((p) => p.brand.toLowerCase() == brand.toLowerCase()).toList();
    }

    if (minPrice != null) {
      list = list.where((p) => p.discountedPrice >= minPrice).toList();
    }

    if (maxPrice != null) {
      list = list.where((p) => p.discountedPrice <= maxPrice).toList();
    }

    if (noCostEmiOnly == true) {
      list = list.where((p) => p.hasNoCostEmi).toList();
    }

    if (sortBy != null) {
      switch (sortBy) {
        case 'price_low_high':
          list.sort((a, b) => a.discountedPrice.compareTo(b.discountedPrice));
          break;
        case 'price_high_low':
          list.sort((a, b) => b.discountedPrice.compareTo(a.discountedPrice));
          break;
        case 'rating':
          list.sort((a, b) => b.rating.compareTo(a.rating));
          break;
        case 'emi_low_high':
          list.sort((a, b) => a.startingEmiPerMonth.compareTo(b.startingEmiPerMonth));
          break;
        default:
          // Popularity / default
          break;
      }
    }

    return list;
  }

  @override
  Future<ProductModel?> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _categories;
  }

  @override
  Future<List<String>> getAvailableBrands() async {
    await Future.delayed(const Duration(milliseconds: 50));
    final brands = _products.map((p) => p.brand).toSet().toList();
    brands.sort();
    return ['All Brands', ...brands];
  }

  @override
  Future<List<ProductModel>> getTrendingProducts() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _products.where((p) => p.isTrending).toList();
  }
}
