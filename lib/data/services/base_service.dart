import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';

abstract class BaseService {
  final String baseUrl = AppConstants.baseUrl;
  final http.Client _client = http.Client();

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/$endpoint'));
      return _handleResponse(response);
    } catch (e) {
      throw Exception(AppConstants.networkError);
    }
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/$endpoint'),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception(AppConstants.networkError);
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      throw Exception(AppConstants.genericError);
    }
  }

  void dispose() {
    _client.close();
  }
} 