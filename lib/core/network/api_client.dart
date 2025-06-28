import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  final Dio _dio;

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
          // String? token = await SecureStorageService.get(SecureStorageKeys.accessToken);
          // if (token != null) {
          options.headers['Authorization'] = 'Bearer token';
          // }
          handler.next(options);
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
      print('response');
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // ✅ Generic PUT request
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

  // Error handling
  Response _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        if (kDebugMode) print("Connection Timeout Error: ${error.message}");
        break;
      case DioExceptionType.sendTimeout:
        if (kDebugMode) print("Send Timeout Error: ${error.message}");
        break;
      case DioExceptionType.receiveTimeout:
        if (kDebugMode) print("Receive Timeout Error: ${error.message}");
        break;
      case DioExceptionType.badResponse:
        if (kDebugMode) print("Bad Response Error: ${error.response?.data}");
        return error.response!;
      case DioExceptionType.cancel:
        if (kDebugMode) print("Request Cancelled: ${error.message}");
        break;
      case DioExceptionType.badCertificate:
        if (kDebugMode) print("Bad Certificate Error: ${error.message}");
        break;
      case DioExceptionType.connectionError:
        if (kDebugMode) print("Connection Error: ${error.message}");
        break;
      case DioExceptionType.unknown:
        if (kDebugMode) print("Unknown Error: ${error.message}");
        break;
    }

    return error.response ??
        Response(
          requestOptions: RequestOptions(path: error.requestOptions.path),
          statusCode: 500,
          statusMessage: 'An unknown error occurred.',
        );
  }

  // ✅ Generic DELETE request
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

}
