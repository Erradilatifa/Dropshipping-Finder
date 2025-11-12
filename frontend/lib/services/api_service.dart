import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final String baseUrl = 'http://localhost:8000/api';
  String? _authToken;

  void setAuthToken(String token) {
    _authToken = token;
  }

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (_authToken != null) 'Authorization': 'Bearer $_authToken',
      };

  // Authentication
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login/'),
        headers: _headers,
        body: jsonEncode({'username': email, 'password': password}),
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      // Split name into first and last name
      final nameParts = name.trim().split(' ');
      final firstName = nameParts.isNotEmpty ? nameParts[0] : name;
      final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
      
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register/'),
        headers: _headers,
        body: jsonEncode({
            'username': email.split('@')[0], // Use email prefix as username
            'email': email,
            'password': password,
            'password_confirm': password,
            'first_name': firstName,
            'last_name': lastName,
          }),
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // User Profile
  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/me/'),
        headers: _headers,
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> updateProfile(String name, String email) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/users/me/'),
        headers: _headers,
        body: jsonEncode({'name': name, 'email': email}),
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Products
  Future<Map<String, dynamic>> getProducts({int page = 1, int limit = 20}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/?page=$page&limit=$limit'),
        headers: _headers,
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getTrendingProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/trending/'),
        headers: _headers,
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> searchProducts(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/search/?q=$query'),
        headers: _headers,
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getProductById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/$id/'),
        headers: _headers,
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Favorites
  Future<Map<String, dynamic>> getFavorites() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/favorites/'),
        headers: _headers,
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> toggleFavorite(String productId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/favorites/toggle/'),
        headers: _headers,
        body: jsonEncode({'product_id': productId}),
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Subscription
  Future<Map<String, dynamic>> updateSubscription(String plan) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/subscription/update/'),
        headers: _headers,
        body: jsonEncode({'plan': plan}),
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Settings
  Future<Map<String, dynamic>> updateNotificationSettings(bool enabled) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/settings/notifications/'),
        headers: _headers,
        body: jsonEncode({'enabled': enabled}),
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Helper method to handle responses
  Map<String, dynamic> _handleResponse(http.Response response) {
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body);
        // Handle both list and map responses
        if (data is List) {
          return {'success': true, 'data': data};
        } else if (data is Map) {
          return {'success': true, ...data};
        } else {
          return {'success': true, 'data': data};
        }
      } else {
        // Try to parse error as JSON
        try {
          final error = jsonDecode(response.body);
          return {
            'success': false,
            'message': error['message'] ?? error['detail'] ?? 'Request failed',
          };
        } catch (e) {
          // If response is not JSON (e.g., HTML error page)
          return {
            'success': false,
            'message': 'Server error (${response.statusCode}): ${response.body.substring(0, response.body.length > 100 ? 100 : response.body.length)}',
          };
        }
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to parse response: $e',
      };
    }
  }
}






