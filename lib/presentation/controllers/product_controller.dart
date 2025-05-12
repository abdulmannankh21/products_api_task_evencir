import 'package:get/get.dart';
import '../../data/services/api_service.dart';
import '../../domain/models/product_model.dart';
import '../../domain/models/category_model.dart';

/// Controller responsible for managing product-related operations and state.
class ProductController extends GetxController {
  /// API service for making network requests
  final ApiService _apiService = ApiService();
  
  /// Observable list of all products
  final RxList<Product> products = <Product>[].obs;
  
  /// Observable list of filtered products based on search or category
  final RxList<Product> filteredProducts = <Product>[].obs;
  
  /// Observable list of favorite products
  final RxList<Product> favoriteProducts = <Product>[].obs;
  
  /// Observable list of product categories
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  
  /// Observable loading state
  final RxBool isLoading = false.obs;
  
  /// Observable search query
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  /// Initializes the controller by fetching initial data
  Future<void> _initializeData() async {
    await Future.wait([
      fetchProducts(),
      fetchCategories(),
    ]);
  }

  /// Fetches all products from the API
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final response = await _apiService.getProducts();
      products.value = response.products ?? [];
      filteredProducts.value = products;
    } catch (e) {
      _handleError('Failed to fetch products', e);
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetches all product categories from the API
  Future<void> fetchCategories() async {
    try {
      final List<CategoryModel> response = await _apiService.getCategories();
      categories.value = response;
    } catch (e) {
      _handleError('Failed to fetch categories', e);
    }
  }

  /// Fetches products filtered by category
  /// 
  /// [categoryUrl] The URL of the category to filter by
  Future<void> fetchProductsByCategory(String categoryUrl) async {
    try {
      isLoading.value = true;
      final response = await _apiService.getProductsByCategory(categoryUrl);
      products.value = response.products ?? [];
      filteredProducts.value = products;
    } catch (e) {
      _handleError('Failed to fetch products by category', e);
    } finally {
      isLoading.value = false;
    }
  }

  /// Searches products based on the provided query
  /// 
  /// [query] The search query to filter products by
  void searchProducts(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredProducts.value = products;
      return;
    }

    final String lowercaseQuery = query.toLowerCase();
    filteredProducts.value = products.where((Product product) {
      final String? title = product.title?.toLowerCase();
      final String? description = product.description?.toLowerCase();
      
      return (title?.contains(lowercaseQuery) ?? false) ||
             (description?.contains(lowercaseQuery) ?? false);
    }).toList();
  }

  /// Toggles the favorite status of a product
  /// 
  /// [product] The product to toggle favorite status for
  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      favoriteProducts.removeWhere((Product p) => p.id == product.id);
    } else {
      favoriteProducts.add(product);
    }
  }

  /// Checks if a product is in the favorites list
  /// 
  /// [product] The product to check
  /// Returns true if the product is in favorites, false otherwise
  bool isFavorite(Product product) {
    return favoriteProducts.any((Product p) => p.id == product.id);
  }

  /// Searches through favorite products
  /// 
  /// [query] The search query to filter favorite products by
  void searchFavorites(String query) {
    if (query.isEmpty) {
      filteredProducts.value = favoriteProducts;
      return;
    }

    final String lowercaseQuery = query.toLowerCase();
    filteredProducts.value = favoriteProducts.where((Product product) {
      final String? title = product.title?.toLowerCase();
      final String? description = product.description?.toLowerCase();
      
      return (title?.contains(lowercaseQuery) ?? false) ||
             (description?.contains(lowercaseQuery) ?? false);
    }).toList();
  }

  /// Handles errors by showing a snackbar with the error message
  /// 
  /// [message] The error message to display
  /// [error] The error object
  void _handleError(String message, dynamic error) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
    // TODO: Add proper error logging
    print('Error: $error');
  }
} 