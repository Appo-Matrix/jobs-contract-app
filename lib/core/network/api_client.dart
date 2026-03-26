// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import '../../data/data_source/local/AuthPreferences.dart';
//
// class ApiClient {
//   final Dio _dio;
//   static const int _maxRetries = 3;
//   static const Duration _retryDelay = Duration(seconds: 2);
//
//   ApiClient(String baseUrl)
//       : _dio = Dio(BaseOptions(
//     baseUrl: baseUrl,
//     connectTimeout: const Duration(seconds: 30), // ✅ increased
//     receiveTimeout: const Duration(seconds: 30), // ✅ increased
//     headers: {
//       'Content-Type': 'application/json',
//     },
//   )) {
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           String? token = await AuthPreferences.getToken();
//           if (token != null && token.isNotEmpty) {
//             options.headers['Authorization'] = 'Bearer $token';
//             if (kDebugMode) print('✅ Token attached to request');
//           } else {
//             if (kDebugMode) print('⚠️ No token found in secure storage');
//           }
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
//   // ─── Retry logic ───────────────────────────────────────────────────────────
//
//   bool _shouldRetry(DioException e) {
//     return e.type == DioExceptionType.connectionTimeout ||
//         e.type == DioExceptionType.receiveTimeout ||
//         e.type == DioExceptionType.sendTimeout ||
//         e.type == DioExceptionType.connectionError;
//   }
//
//   Future<Response> _withRetry(Future<Response> Function() request) async {
//     int attempt = 0;
//     while (true) {
//       try {
//         return await request();
//       } on DioException catch (e) {
//         attempt++;
//         if (_shouldRetry(e) && attempt < _maxRetries) {
//           if (kDebugMode) {
//             print('🔄 Retry attempt $attempt/$_maxRetries after ${_retryDelay.inSeconds}s...');
//           }
//           await Future.delayed(_retryDelay);
//           continue;
//         }
//         // ✅ all retries exhausted or non-retryable error
//         return _handleError(e);
//       }
//     }
//   }
//
//   // ─── GET ───────────────────────────────────────────────────────────────────
//
//   Future<Response> get(
//       String endpoint, {
//         Map<String, dynamic>? queryParameters,
//       }) async {
//     return _withRetry(
//           () => _dio.get(endpoint, queryParameters: queryParameters),
//     );
//   }
//
//   // ─── POST ──────────────────────────────────────────────────────────────────
//
//   Future<Response> post({
//     required String endpoint,
//     Map<String, dynamic>? data,
//   }) async {
//     return _withRetry(
//           () => _dio.post(endpoint, data: data),
//     );
//   }
//
//   // ─── PUT ───────────────────────────────────────────────────────────────────
//
//   Future<Response> put({
//     required String endpoint,
//     Map<String, dynamic>? data,
//   }) async {
//     return _withRetry(
//           () => _dio.put(endpoint, data: data),
//     );
//   }
//
//   // ─── DELETE ────────────────────────────────────────────────────────────────
//
//   Future<Response> delete({
//     required String endpoint,
//     Map<String, dynamic>? data,
//   }) async {
//     return _withRetry(
//           () => _dio.delete(endpoint, data: data),
//     );
//   }
//
//   // ─── Multipart POST ────────────────────────────────────────────────────────
//
//   Future<Response> postMultipart({
//     required String endpoint,
//     required FormData data,
//   }) async {
//     return _withRetry(
//           () => _dio.post(
//         endpoint,
//         data: data,
//         options: Options(contentType: 'multipart/form-data'),
//       ),
//     );
//   }
//
//   // ─── Multipart PUT ─────────────────────────────────────────────────────────
//
//   Future<Response> putMultipart({
//     required String endpoint,
//     required FormData data,
//   }) async {
//     return _withRetry(
//           () => _dio.put(
//         endpoint,
//         data: data,
//         options: Options(
//           headers: {'Content-Type': 'multipart/form-data'},
//         ),
//       ),
//     );
//   }
//
//   // ─── PATCH ─────────────────────────────────────────────────────────────────
//
//   Future<Response> patch(
//       String path, {
//         Map<String, dynamic>? data,
//         Map<String, dynamic>? queryParameters,
//         Options? options,
//       }) async {
//     return _withRetry(
//           () => _dio.patch(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//       ),
//     );
//   }
//
//   // ─── Error handler ─────────────────────────────────────────────────────────
//
//   Response _handleError(DioException error) {
//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//       case DioExceptionType.sendTimeout:
//       case DioExceptionType.receiveTimeout:
//         if (kDebugMode) print("❌ Timeout after $_maxRetries retries: ${error.message}");
//         return Response(
//           requestOptions: error.requestOptions,
//           statusCode: 408,
//           data: {'message': 'Connection timeout after $_maxRetries retries. Please try again.'},
//         );
//       case DioExceptionType.connectionError:
//         if (kDebugMode) print("❌ Connection Error after $_maxRetries retries: ${error.message}");
//         return Response(
//           requestOptions: error.requestOptions,
//           statusCode: 503,
//           data: {'message': 'No internet connection. Please check your network.'},
//         );
//       case DioExceptionType.badResponse:
//         if (kDebugMode) print("❌ Bad Response: ${error.response?.data}");
//         return error.response!;
//       case DioExceptionType.cancel:
//         if (kDebugMode) print("❌ Request Cancelled: ${error.message}");
//         return Response(
//           requestOptions: error.requestOptions,
//           statusCode: 499,
//           data: {'message': 'Request was cancelled.'},
//         );
//       default:
//         if (kDebugMode) print("❌ Unknown Error: ${error.message}");
//         return Response(
//           requestOptions: error.requestOptions,
//           statusCode: 500,
//           data: {'message': 'An unexpected error occurred.'},
//         );
//     }
//   }
// }



import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../data/data_source/local/AuthPreferences.dart';

class ApiClient {
  final Dio _dio;
  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(seconds: 2);

  // ✅ Track in-flight requests for cancellation support
  final Map<String, CancelToken> _cancelTokens = {};

  ApiClient(String baseUrl)
      : _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
    },
  )) {
    _dio.interceptors.addAll([
      // ✅ Auth + request logging interceptor (unchanged logic, better logs)
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await AuthPreferences.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            if (kDebugMode) {
              debugPrint('➡️  [${options.method}] ${options.uri}');
              debugPrint('    Headers: ${options.headers}');
            }
          } else {
            if (kDebugMode) {
              debugPrint('⚠️  [${options.method}] ${options.uri} — no token');
            }
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // ✅ Log successful responses
          if (kDebugMode) {
            debugPrint(
              '✅ [${response.requestOptions.method}] '
                  '${response.requestOptions.uri} → ${response.statusCode}',
            );
          }
          return handler.next(response);
        },
        onError: (error, handler) async {
          if (kDebugMode) {
            debugPrint(
              '❌ [${error.requestOptions.method}] '
                  '${error.requestOptions.uri} → '
                  '${error.response?.statusCode} | ${error.message}',
            );
            // ✅ Log response body on error for easier debugging
            if (error.response?.data != null) {
              debugPrint('   Body: ${error.response?.data}');
            }
          }
          return handler.next(error);
        },
      ),

      // ✅ Separate logging interceptor for request/response body in debug
      if (kDebugMode) LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (log) => debugPrint('📦 $log'),
      ),
    ]);
  }

  // ─── Retry logic ───────────────────────────────────────────────────────────

  bool _shouldRetry(DioException e) {
    return e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.connectionError;
  }

  Future<Response> _withRetry(
      Future<Response> Function() request, {
        // ✅ Optional tag to support per-request cancellation
        String? cancelTag,
      }) async {
    int attempt = 0;

    // ✅ Register a cancel token if a tag was provided
    if (cancelTag != null) {
      _cancelTokens[cancelTag] = CancelToken();
    }

    while (true) {
      try {
        return await request();
      } on DioException catch (e) {
        // ✅ If the request was cancelled, propagate immediately — don't retry
        if (e.type == DioExceptionType.cancel) {
          if (kDebugMode) debugPrint('🚫 Request cancelled: $cancelTag');
          return _handleError(e);
        }

        attempt++;
        if (_shouldRetry(e) && attempt < _maxRetries) {
          if (kDebugMode) {
            debugPrint(
              '🔄 Retry $attempt/$_maxRetries '
                  'after ${_retryDelay.inSeconds}s — ${e.type.name}',
            );
          }
          await Future.delayed(_retryDelay);
          continue;
        }
        return _handleError(e);
      } finally {
        // ✅ Clean up cancel token after request completes
        if (cancelTag != null) {
          _cancelTokens.remove(cancelTag);
        }
      }
    }
  }

  // ✅ Cancel an in-flight request by its tag
  void cancelRequest(String tag, {String? reason}) {
    final token = _cancelTokens[tag];
    if (token != null && !token.isCancelled) {
      token.cancel(reason ?? 'Cancelled by caller');
      if (kDebugMode) debugPrint('🚫 Cancelled request: $tag');
    }
  }

  // ✅ Cancel all in-flight requests (useful on logout)
  void cancelAllRequests({String? reason}) {
    for (final entry in _cancelTokens.entries) {
      if (!entry.value.isCancelled) {
        entry.value.cancel(reason ?? 'All requests cancelled');
      }
    }
    _cancelTokens.clear();
    if (kDebugMode) debugPrint('🚫 All in-flight requests cancelled');
  }

  // ─── GET ───────────────────────────────────────────────────────────────────

  Future<Response> get(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
        String? cancelTag, // ✅ optional cancellation tag
      }) async {
    return _withRetry(
          () => _dio.get(
        endpoint,
        queryParameters: queryParameters,
        cancelToken: cancelTag != null ? _cancelTokens[cancelTag] : null,
      ),
      cancelTag: cancelTag,
    );
  }

  // ─── POST ──────────────────────────────────────────────────────────────────

  Future<Response> post({
    required String endpoint,
    Map<String, dynamic>? data,
    String? cancelTag,
  }) async {
    return _withRetry(
          () => _dio.post(
        endpoint,
        data: data,
        cancelToken: cancelTag != null ? _cancelTokens[cancelTag] : null,
      ),
      cancelTag: cancelTag,
    );
  }

  // ─── PUT ───────────────────────────────────────────────────────────────────

  Future<Response> put({
    required String endpoint,
    Map<String, dynamic>? data,
    String? cancelTag,
  }) async {
    return _withRetry(
          () => _dio.put(
        endpoint,
        data: data,
        cancelToken: cancelTag != null ? _cancelTokens[cancelTag] : null,
      ),
      cancelTag: cancelTag,
    );
  }

  // ─── DELETE ────────────────────────────────────────────────────────────────

  Future<Response> delete({
    required String endpoint,
    Map<String, dynamic>? data,
    String? cancelTag,
  }) async {
    return _withRetry(
          () => _dio.delete(
        endpoint,
        data: data,
        cancelToken: cancelTag != null ? _cancelTokens[cancelTag] : null,
      ),
      cancelTag: cancelTag,
    );
  }

  // ─── Multipart POST ────────────────────────────────────────────────────────

  Future<Response> postMultipart({
    required String endpoint,
    required FormData data,
    String? cancelTag,
    // ✅ Optional upload progress callback
    void Function(int sent, int total)? onSendProgress,
  }) async {
    return _withRetry(
          () => _dio.post(
        endpoint,
        data: data,
        onSendProgress: onSendProgress,
        cancelToken: cancelTag != null ? _cancelTokens[cancelTag] : null,
        options: Options(contentType: 'multipart/form-data'),
      ),
      cancelTag: cancelTag,
    );
  }

  // ─── Multipart PUT ─────────────────────────────────────────────────────────

  Future<Response> putMultipart({
    required String endpoint,
    required FormData data,
    String? cancelTag,
    // ✅ Optional upload progress callback
    void Function(int sent, int total)? onSendProgress,
  }) async {
    return _withRetry(
          () => _dio.put(
        endpoint,
        data: data,
        onSendProgress: onSendProgress,
        cancelToken: cancelTag != null ? _cancelTokens[cancelTag] : null,
        options: Options(contentType: 'multipart/form-data'),
      ),
      cancelTag: cancelTag,
    );
  }

  // ─── PATCH ─────────────────────────────────────────────────────────────────

  Future<Response> patch(
      String path, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        String? cancelTag,
      }) async {
    return _withRetry(
          () => _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelTag != null ? _cancelTokens[cancelTag] : null,
      ),
      cancelTag: cancelTag,
    );
  }

  // ─── Error handler ─────────────────────────────────────────────────────────

  Response _handleError(DioException error) {
    // ✅ Extract server message if available, fall back to defaults
    final serverMessage = error.response?.data is Map
        ? error.response?.data['message']?.toString()
        : null;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        if (kDebugMode) {
          debugPrint('❌ Timeout after $_maxRetries retries: ${error.message}');
        }
        return Response(
          requestOptions: error.requestOptions,
          statusCode: 408,
          data: {
            'message': serverMessage ??
                'Connection timeout after $_maxRetries retries. Please try again.',
          },
        );

      case DioExceptionType.connectionError:
        if (kDebugMode) {
          debugPrint(
            '❌ Connection error after $_maxRetries retries: ${error.message}',
          );
        }
        return Response(
          requestOptions: error.requestOptions,
          statusCode: 503,
          data: {
            'message': serverMessage ??
                'No internet connection. Please check your network.',
          },
        );

      case DioExceptionType.badResponse:
        if (kDebugMode) debugPrint('❌ Bad response: ${error.response?.data}');
        return error.response!;

      case DioExceptionType.cancel:
        if (kDebugMode) debugPrint('❌ Request cancelled: ${error.message}');
        return Response(
          requestOptions: error.requestOptions,
          statusCode: 499,
          data: {'message': 'Request was cancelled.'},
        );

      default:
        if (kDebugMode) debugPrint('❌ Unknown error: ${error.message}');
        return Response(
          requestOptions: error.requestOptions,
          statusCode: 500,
          data: {
            'message': serverMessage ?? 'An unexpected error occurred.',
          },
        );
    }
  }
}