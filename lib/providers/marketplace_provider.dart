import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';
import '../repositories/product_repository.dart';

class MarketplaceProvider with ChangeNotifier {
  final ProductRepository repository;

  MarketplaceProvider({required this.repository}) {
    init();
  }

  // State
  List<ProductModel> _products = [];
  List<CategoryModel> _categories = [];
  List<String> _brands = [];
  final Set<String> _wishlistIds = {};

  bool _isLoading = false;
  String? _errorMessage;

  // Filter & Search states
  String _selectedCategoryId = 'all';
  String _searchQuery = '';
  String _selectedBrand = 'All Brands';
  double _minPrice = 0.0;
  double _maxPrice = 250000.0;
  bool _noCostEmiOnly = false;
  String _sortBy = 'default';

  // Getters
  List<ProductModel> get products => _products;
  List<CategoryModel> get categories => _categories;
  List<String> get brands => _brands;
  Set<String> get wishlistIds => _wishlistIds;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  String get selectedCategoryId => _selectedCategoryId;
  String get searchQuery => _searchQuery;
  String get selectedBrand => _selectedBrand;
  double get minPrice => _minPrice;
  double get maxPrice => _maxPrice;
  bool get noCostEmiOnly => _noCostEmiOnly;
  String get sortBy => _sortBy;

  int get activeFilterCount {
    int count = 0;
    if (_selectedBrand != 'All Brands') count++;
    if (_noCostEmiOnly) count++;
    if (_minPrice > 0 || _maxPrice < 250000) count++;
    if (_sortBy != 'default') count++;
    return count;
  }

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      _categories = await repository.getCategories();
      _brands = await repository.getAvailableBrands();
      await fetchProducts();
    } catch (e) {
      _errorMessage = 'Failed to load marketplace: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await repository.getProducts(
        categoryId: _selectedCategoryId,
        searchQuery: _searchQuery,
        brand: _selectedBrand,
        minPrice: _minPrice,
        maxPrice: _maxPrice,
        noCostEmiOnly: _noCostEmiOnly,
        sortBy: _sortBy,
      );
    } catch (e) {
      _errorMessage = 'Unable to fetch products. Please check your connection.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectCategory(String categoryId) {
    if (_selectedCategoryId != categoryId) {
      _selectedCategoryId = categoryId;
      fetchProducts();
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    fetchProducts();
  }

  void setBrand(String brand) {
    _selectedBrand = brand;
    fetchProducts();
  }

  void setPriceRange(double min, double max) {
    _minPrice = min;
    _maxPrice = max;
    fetchProducts();
  }

  void setNoCostEmiOnly(bool val) {
    _noCostEmiOnly = val;
    fetchProducts();
  }

  void setSortBy(String sort) {
    _sortBy = sort;
    fetchProducts();
  }

  void resetFilters() {
    _selectedBrand = 'All Brands';
    _minPrice = 0.0;
    _maxPrice = 250000.0;
    _noCostEmiOnly = false;
    _sortBy = 'default';
    fetchProducts();
  }

  void toggleWishlist(String productId) {
    if (_wishlistIds.contains(productId)) {
      _wishlistIds.remove(productId);
    } else {
      _wishlistIds.add(productId);
    }
    notifyListeners();
  }

  bool isInWishlist(String productId) => _wishlistIds.contains(productId);
}
