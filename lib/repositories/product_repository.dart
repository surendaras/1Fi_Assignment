import '../models/product_model.dart';
import '../models/category_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts({
    String? categoryId,
    String? searchQuery,
    double? minPrice,
    double? maxPrice,
    String? brand,
    bool? noCostEmiOnly,
    String? sortBy,
  });

  Future<ProductModel?> getProductById(String id);

  Future<List<CategoryModel>> getCategories();

  Future<List<String>> getAvailableBrands();

  Future<List<ProductModel>> getTrendingProducts();
}
