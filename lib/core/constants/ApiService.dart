// lib/data/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://arquimatch.eu-4.evennode.com';

  // HTTP client for making requests
  final http.Client _client;

  // Constructor with optional client parameter for testing
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  // Check if the API is reachable
  Future<bool> checkApiStatus() async {
    try {
      final response = await _client.get(Uri.parse(baseUrl));
      return response.statusCode == 200;
    } catch (e) {
      print('Error checking API status: $e');
      return false;
    }
  }

  // Generic GET request method
  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Generic POST request method
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Add other methods like PUT, DELETE as needed

  // Don't forget to close the client when done
  void dispose() {
    _client.close();
  }
}