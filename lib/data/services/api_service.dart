import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/models/product_model.dart';
import '../../domain/models/category_model.dart';

class ApiService {
  final Dio _dio;

  ApiService() : _dio = Dio(BaseOptions(
    baseUrl: 'https://dummyjson.com',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  Future<ProductAPiModel> getProducts({int limit = 100}) async {
    try {
      final response = await _dio.get('/products', queryParameters: {'limit': limit});
      if (response.data is Map<String, dynamic>) {
        return ProductAPiModel.fromJson(response.data as Map<String, dynamic>);
      }
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Failed to fetch products');
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final response = await _dio.get('/products/$id');
      if (response.data is Map<String, dynamic>) {
        return Product.fromJson(response.data as Map<String, dynamic>);
      }
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Failed to fetch product details');
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dio.get('/products/categories');
      if (response.data is List) {
        final List<dynamic> categoriesJson = response.data as List;
        return categoriesJson.map((json) {
          if (json is Map<String, dynamic>) {
            return CategoryModel.fromJson(json);
          }
          throw Exception('Invalid category format');
        }).toList();
      }
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Failed to fetch categories');
    }
  }

  Future<ProductAPiModel> getProductsByCategory(String categoryUrl) async {
    try {
      final response = await _dio.get(categoryUrl);
      if (response.data is Map<String, dynamic>) {
        return ProductAPiModel.fromJson(response.data as Map<String, dynamic>);
      }
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Failed to fetch products by category');
    }
  }
} 