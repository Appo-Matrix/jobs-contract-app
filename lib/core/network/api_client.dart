// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// import '../../data/data_source/local/AuthPreferences.dart';
//
// class ApiClient {
//   final Dio _dio;
//
//   // Use consistent key everywhere
//
//   ApiClient(String baseUrl)
//       : _dio = Dio(BaseOptions(
//     baseUrl: baseUrl,
//     connectTimeout: const Duration(seconds: 10),
//     receiveTimeout: const Duration(seconds: 10),
//     headers: {
//       'Content-Type': 'application/json',
//     },
//   )) {
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           // Get actual token from secure storage using CORRECT key
//           // String? token = await _secureStorage.read(key: _tokenKey);
//           String? token = await AuthPreferences.getToken();
//
//           print("Auth token is $token");
//           if (token != null && token.isNotEmpty) {
//             options.headers['Authorization'] = 'Bearer $token';
//             if (kDebugMode) print('✅ Token attached: ${token.substring(0, 20)}...');
//           } else {
//             if (kDebugMode) print('⚠️ No token found in secure storage');
//           }
//
//           if (kDebugMode) print('🔑 Request Headers: ${options.headers}');
//
//           return handler.next(options);
//         },
//         onError: (error, handler) async {
//           if (kDebugMode) print('❌ Error: ${error.response?.statusCode}');
//           return handler.next(error);
//         },
//       ),
//     );
//   }
//
//   // Generic GET request
//   Future<Response> get(String endpoint,
//       {Map<String, dynamic>? queryParameters}) async {
//     try {
//       final response =
//       await _dio.get(endpoint, queryParameters: queryParameters);
//       return response;
//     } on DioException catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   // Generic POST request
//   Future<Response> post({
//     required String endpoint,
//     Map<String, dynamic>? data,
//   }) async {
//     try {
//       final response = await _dio.post(endpoint, data: data);
//       if (kDebugMode) print('✅ POST Response: ${response.statusCode}');
//       return response;
//     } on DioException catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   // Generic PUT request
//   Future<Response> put({
//     required String endpoint,
//     Map<String, dynamic>? data,
//   }) async {
//     try {
//       final response = await _dio.put(endpoint, data: data);
//       return response;
//     } on DioException catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   // Generic DELETE request
//   Future<Response> delete({
//     required String endpoint,
//     Map<String, dynamic>? data,
//   }) async {
//     try {
//       final response = await _dio.delete(
//         endpoint,
//         data: data,
//       );
//       return response;
//     } on DioException catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   // Multipart POST request
//   Future<Response> postMultipart({
//     required String endpoint,
//     required FormData data,
//   }) async {
//     try {
//       final response = await _dio.post(
//         endpoint,
//         data: data,
//         options: Options(
//           contentType: 'multipart/form-data',
//         ),
//       );
//       return response;
//     } on DioException catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   // Multipart PUT request
//   Future<Response> putMultipart({
//     required String endpoint,
//     required FormData data,
//   }) async {
//     try {
//       final response = await _dio.put(
//         endpoint,
//         data: data,
//         options: Options(
//           headers: {
//             'Content-Type': 'multipart/form-data',
//           },
//         ),
//       );
//       return response;
//     } on DioException catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   // PATCH request
//   Future<Response> patch(
//       String path, {
//         Map<String, dynamic>? data,
//         Map<String, dynamic>? queryParameters,
//         Options? options,
//       }) async {
//     try {
//       final response = await _dio.patch(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//       );
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   // Error handling
//   Response _handleError(DioException error) {
//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//         if (kDebugMode) print("❌ Connection Timeout Error: ${error.message}");
//         break;
//       case DioExceptionType.sendTimeout:
//         if (kDebugMode) print("❌ Send Timeout Error: ${error.message}");
//         break;
//       case DioExceptionType.receiveTimeout:
//         if (kDebugMode) print("❌ Receive Timeout Error: ${error.message}");
//         break;
//       case DioExceptionType.badResponse:
//         if (kDebugMode) print("❌ Bad Response Error: ${error.response?.data}");
//         return error.response!;
//       case DioExceptionType.cancel:
//         if (kDebugMode) print("❌ Request Cancelled: ${error.message}");
//         break;
//       case DioExceptionType.badCertificate:
//         if (kDebugMode) print("❌ Bad Certificate Error: ${error.message}");
//         break;
//       case DioExceptionType.connectionError:
//         if (kDebugMode) print("❌ Connection Error: ${error.message}");
//         break;
//       case DioExceptionType.unknown:
//         if (kDebugMode) print("❌ Unknown Error: ${error.message}");
//         break;
//     }
//
//     return error.response ??
//         Response(
//           requestOptions: RequestOptions(path: error.requestOptions.path),
//           statusCode: 500,
//           statusMessage: 'An unknown error occurred.',
//         );
//   }
//
//
//
// }


import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../data/data_source/local/AuthPreferences.dart';

class ApiClient {
  final Dio _dio;
  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(seconds: 2);

  ApiClient(String baseUrl)
      : _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 30), // ✅ increased
    receiveTimeout: const Duration(seconds: 30), // ✅ increased
    headers: {
      'Content-Type': 'application/json',
    },
  )) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await AuthPreferences.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            if (kDebugMode) print('✅ Token attached to request');
          } else {
            if (kDebugMode) print('⚠️ No token found in secure storage');
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (kDebugMode) print('❌ Error: ${error.response?.statusCode}');
          return handler.next(error);
        },
      ),
    );
  }

  // ─── Retry logic ───────────────────────────────────────────────────────────

  bool _shouldRetry(DioException e) {
    return e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.connectionError;
  }

  Future<Response> _withRetry(Future<Response> Function() request) async {
    int attempt = 0;
    while (true) {
      try {
        return await request();
      } on DioException catch (e) {
        attempt++;
        if (_shouldRetry(e) && attempt < _maxRetries) {
          if (kDebugMode) {
            print('🔄 Retry attempt $attempt/$_maxRetries after ${_retryDelay.inSeconds}s...');
          }
          await Future.delayed(_retryDelay);
          continue;
        }
        // ✅ all retries exhausted or non-retryable error
        return _handleError(e);
      }
    }
  }

  // ─── GET ───────────────────────────────────────────────────────────────────

  Future<Response> get(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
      }) async {
    return _withRetry(
          () => _dio.get(endpoint, queryParameters: queryParameters),
    );
  }

  // ─── POST ──────────────────────────────────────────────────────────────────

  Future<Response> post({
    required String endpoint,
    Map<String, dynamic>? data,
  }) async {
    return _withRetry(
          () => _dio.post(endpoint, data: data),
    );
  }

  // ─── PUT ───────────────────────────────────────────────────────────────────

  Future<Response> put({
    required String endpoint,
    Map<String, dynamic>? data,
  }) async {
    return _withRetry(
          () => _dio.put(endpoint, data: data),
    );
  }

  // ─── DELETE ────────────────────────────────────────────────────────────────

  Future<Response> delete({
    required String endpoint,
    Map<String, dynamic>? data,
  }) async {
    return _withRetry(
          () => _dio.delete(endpoint, data: data),
    );
  }

  // ─── Multipart POST ────────────────────────────────────────────────────────

  Future<Response> postMultipart({
    required String endpoint,
    required FormData data,
  }) async {
    return _withRetry(
          () => _dio.post(
        endpoint,
        data: data,
        options: Options(contentType: 'multipart/form-data'),
      ),
    );
  }

  // ─── Multipart PUT ─────────────────────────────────────────────────────────

  Future<Response> putMultipart({
    required String endpoint,
    required FormData data,
  }) async {
    return _withRetry(
          () => _dio.put(
        endpoint,
        data: data,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
        ),
      ),
    );
  }

  // ─── PATCH ─────────────────────────────────────────────────────────────────

  Future<Response> patch(
      String path, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    return _withRetry(
          () => _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  // ─── Error handler ─────────────────────────────────────────────────────────

  Response _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        if (kDebugMode) print("❌ Timeout after $_maxRetries retries: ${error.message}");
        return Response(
          requestOptions: error.requestOptions,
          statusCode: 408,
          data: {'message': 'Connection timeout after $_maxRetries retries. Please try again.'},
        );
      case DioExceptionType.connectionError:
        if (kDebugMode) print("❌ Connection Error after $_maxRetries retries: ${error.message}");
        return Response(
          requestOptions: error.requestOptions,
          statusCode: 503,
          data: {'message': 'No internet connection. Please check your network.'},
        );
      case DioExceptionType.badResponse:
        if (kDebugMode) print("❌ Bad Response: ${error.response?.data}");
        return error.response!;
      case DioExceptionType.cancel:
        if (kDebugMode) print("❌ Request Cancelled: ${error.message}");
        return Response(
          requestOptions: error.requestOptions,
          statusCode: 499,
          data: {'message': 'Request was cancelled.'},
        );
      default:
        if (kDebugMode) print("❌ Unknown Error: ${error.message}");
        return Response(
          requestOptions: error.requestOptions,
          statusCode: 500,
          data: {'message': 'An unexpected error occurred.'},
        );
    }
  }
}