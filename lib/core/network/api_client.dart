import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Use consistent key everywhere
  static const String _tokenKey = 'auth_token';

  ApiClient(String baseUrl)
      : _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
    },
  )) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Get actual token from secure storage using CORRECT key
          String? token = await _secureStorage.read(key: _tokenKey);

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            if (kDebugMode) print('✅ Token attached: ${token.substring(0, 20)}...');
          } else {
            if (kDebugMode) print('⚠️ No token found in secure storage');
          }

          if (kDebugMode) print('🔑 Request Headers: ${options.headers}');

          return handler.next(options);
        },
        onError: (error, handler) async {
          if (kDebugMode) print('❌ Error: ${error.response?.statusCode}');
          return handler.next(error);
        },
      ),
    );
  }

  // Generic GET request
  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
      await _dio.get(endpoint, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // Generic POST request
  Future<Response> post({
    required String endpoint,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      if (kDebugMode) print('✅ POST Response: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // Generic PUT request
  Future<Response> put({
    required String endpoint,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // Generic DELETE request
  Future<Response> delete({
    required String endpoint,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // Multipart POST request
  Future<Response> postMultipart({
    required String endpoint,
    required FormData data,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // Multipart PUT request
  Future<Response> putMultipart({
    required String endpoint,
    required FormData data,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // PATCH request
  Future<Response> patch(
      String path, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Error handling
  Response _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        if (kDebugMode) print("❌ Connection Timeout Error: ${error.message}");
        break;
      case DioExceptionType.sendTimeout:
        if (kDebugMode) print("❌ Send Timeout Error: ${error.message}");
        break;
      case DioExceptionType.receiveTimeout:
        if (kDebugMode) print("❌ Receive Timeout Error: ${error.message}");
        break;
      case DioExceptionType.badResponse:
        if (kDebugMode) print("❌ Bad Response Error: ${error.response?.data}");
        return error.response!;
      case DioExceptionType.cancel:
        if (kDebugMode) print("❌ Request Cancelled: ${error.message}");
        break;
      case DioExceptionType.badCertificate:
        if (kDebugMode) print("❌ Bad Certificate Error: ${error.message}");
        break;
      case DioExceptionType.connectionError:
        if (kDebugMode) print("❌ Connection Error: ${error.message}");
        break;
      case DioExceptionType.unknown:
        if (kDebugMode) print("❌ Unknown Error: ${error.message}");
        break;
    }

    return error.response ??
        Response(
          requestOptions: RequestOptions(path: error.requestOptions.path),
          statusCode: 500,
          statusMessage: 'An unknown error occurred.',
        );
  }

  // Helper method to save tokens using CORRECT key
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
    if (kDebugMode) print('✅ Token saved to secure storage with key: $_tokenKey');
  }

  // Helper method to clear token using CORRECT key
  Future<void> clearToken() async {
    await _secureStorage.delete(key: _tokenKey);
    if (kDebugMode) print('🗑️ Token cleared from secure storage');
  }

  // Helper method to get token using CORRECT key
  Future<String?> getToken() async {
    final token = await _secureStorage.read(key: _tokenKey);
    if (kDebugMode) print('🔑 Retrieved token: ${token != null ? '${token.substring(0, 20)}...' : 'null'}');
    return token;
  }
}