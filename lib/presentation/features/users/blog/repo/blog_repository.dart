import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/constants/api_endpoints.dart';
import '../model/blog_model.dart';

class BlogRepository {
  /// ✅ Exposed as protected (no underscore) so BlogRepositoryImpl can access it
  final Dio dio;

  BlogRepository(this.dio);

  /// Upload image to server and return image URL
  Future<String> uploadImage(File imageFile) async {
    try {
      debugPrint('📸 === UPLOAD IMAGE REQUEST ===');
      debugPrint('File path: ${imageFile.path}');
      debugPrint('File size: ${imageFile.lengthSync()} bytes');

      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      final response = await dio.post(
        '${ApiPath.baseUrl}/upload',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {'Accept': 'application/json'},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        String? imageUrl;

        if (responseData is Map<String, dynamic>) {
          imageUrl = responseData['imageUrl']?.toString() ??
              responseData['url']?.toString() ??
              responseData['image']?.toString();

          if (imageUrl == null && responseData['data'] is Map) {
            final dataMap = responseData['data'] as Map<String, dynamic>;
            imageUrl = dataMap['imageUrl']?.toString() ??
                dataMap['url']?.toString();
          }
        }

        if (imageUrl != null && imageUrl.isNotEmpty) {
          return imageUrl;
        }
        throw Exception('No image URL in response');
      }

      throw Exception(
          'Failed to upload image: ${response.statusCode} ${response.statusMessage}');
    } on DioException catch (e) {
      throw _handleDioException(e, 'Failed to upload image');
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  /// ✅ Create blog WITH image as multipart/form-data (ONE REQUEST)
  /// Tags use bracket notation: tags[0]=flutter — parsed as array by Express
  Future<BlogModel> createBlogWithImage({
    required String title,
    required String content,
    required List<String> tags,
    required File imageFile,
  }) async {
    try {
      debugPrint('📤 === CREATE BLOG WITH IMAGE ===');
      debugPrint('Title: $title | Tags: $tags');
      debugPrint('Image: ${imageFile.path} | Size: ${imageFile.lengthSync()} bytes');

      final formData = FormData();
      formData.fields.add(MapEntry('title', title));
      formData.fields.add(MapEntry('content', content));

      for (int i = 0; i < tags.length; i++) {
        formData.fields.add(MapEntry('tags[$i]', tags[i]));
      }

      formData.files.add(
        MapEntry(
          'image',
          await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          ),
        ),
      );

      debugPrint('🌐 Calling API: ${ApiPath.baseUrl}${ApiPath.postBlog}');

      final response = await dio.post(
        '${ApiPath.baseUrl}${ApiPath.postBlog}',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {'Accept': 'application/json'},
        ),
      );

      debugPrint('✅ Status: ${response.statusCode} | Data: ${response.data}');

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          final blogJson =
              (responseData['data'] as Map<String, dynamic>?) ?? responseData;
          return BlogModel.fromJson(blogJson);
        }
        return BlogModel(id: '', title: title, content: content, tags: tags);
      }

      throw Exception(
          'Failed to create blog: ${response.statusCode} ${response.statusMessage}');
    } on DioException catch (e) {
      throw _handleDioException(e, 'Failed to create blog with image');
    } catch (e) {
      throw Exception('Error creating blog with image: $e');
    }
  }

  /// Create a new blog post (JSON — no image)
  Future<BlogModel> createBlog({
    required String title,
    required String content,
    required List<String> tags,
    String? imageUrl,
  }) async {
    try {
      debugPrint('📤 === CREATE BLOG REQUEST ===');
      debugPrint('Title: $title | Tags: $tags | ImageUrl: $imageUrl');

      final data = <String, dynamic>{
        'title': title,
        'content': content,
        'tags': tags,
        if (imageUrl != null && imageUrl.isNotEmpty) 'imageUrl': imageUrl,
      };

      final response = await dio.post(
        '${ApiPath.baseUrl}${ApiPath.postBlog}',
        data: data,
        options: Options(headers: const {'Content-Type': 'application/json'}),
      );

      debugPrint('✅ Status: ${response.statusCode} | Data: ${response.data}');

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          final blogJson =
              (responseData['data'] as Map<String, dynamic>?) ?? responseData;
          return BlogModel.fromJson(blogJson);
        }
        return BlogModel(
            id: '', title: title, content: content, tags: tags, imageUrl: imageUrl);
      }

      throw Exception(
          'Failed to create blog: ${response.statusCode} ${response.statusMessage}');
    } on DioException catch (e) {
      throw _handleDioException(e, 'Failed to create blog');
    } catch (e) {
      throw Exception('Error creating blog: $e');
    }
  }

  /// Fetch list of all blogs
  Future<List<BlogModel>> fetchBlogs() async {
    try {
      debugPrint('🌐 Fetching blogs: ${ApiPath.baseUrl}${ApiPath.postBlog}');

      final response = await dio.get('${ApiPath.baseUrl}${ApiPath.postBlog}');

      if (response.statusCode == 200) {
        return _parseBlogsResponse(response.data);
      }

      throw Exception(
          'Failed to fetch blogs: ${response.statusCode} ${response.statusMessage}');
    } on DioException catch (e) {
      throw _handleDioException(e, 'Failed to fetch blogs');
    } catch (e) {
      throw Exception('Error fetching blogs: $e');
    }
  }

  /// ✅ Fetch blogs by the current authenticated user
  ///
  /// URL: GET /api/v1/blogs/user/{userId}
  /// The userId comes from stored user JSON in AuthService (SharedPrefs).
  /// Bearer token is auto-injected by Dio interceptor in main.dart.
  Future<List<BlogModel>> fetchMyBlogs({required String userId}) async {
    try {
      final url = '${ApiPath.baseUrl}${ApiPath.getBlogByUser}/$userId';

      debugPrint('🔄 === FETCH MY BLOGS ===');
      debugPrint('🌐 Calling API: $url');

      final response = await dio.get(
        url,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      debugPrint('✅ Status: ${response.statusCode} | Data: ${response.data}');

      if (response.statusCode == 200) {
        final blogs = _parseBlogsResponse(response.data);
        debugPrint('✅ Loaded ${blogs.length} user blogs');
        return blogs;
      }

      throw Exception(
          'Failed to fetch my blogs: ${response.statusCode} ${response.statusMessage}');
    } on DioException catch (e) {
      throw _handleDioException(e, 'Failed to fetch my blogs');
    } catch (e) {
      throw Exception('Error fetching my blogs: $e');
    }
  }

  // ============================================================================
  // SHARED PRIVATE HELPERS (also available to BlogRepositoryImpl via inheritance)
  // ============================================================================

  List<BlogModel> _parseBlogsResponse(dynamic responseData) {
    List<dynamic>? listJson;

    if (responseData is Map<String, dynamic>) {
      listJson = (responseData['data'] as List<dynamic>?) ??
          (responseData['blogs'] as List<dynamic>?) ??
          (responseData['results'] as List<dynamic>?);
    } else if (responseData is List<dynamic>) {
      listJson = responseData;
    }

    if (listJson == null) return const [];

    return listJson
        .map((e) => BlogModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Exception _handleDioException(DioException e, String defaultMessage) {
    if (e.response == null) {
      return Exception('Network error: ${e.message ?? "No connection"}');
    }

    debugPrint('❌ DioException status: ${e.response?.statusCode}');
    debugPrint('❌ DioException data: ${e.response?.data}');

    String errorMessage = defaultMessage;
    final data = e.response?.data;

    if (data is Map) {
      errorMessage = data['message']?.toString() ??
          data['error']?.toString() ??
          (data['errors'] is Map
              ? (data['errors'] as Map)
              .entries
              .map((e) => '${e.key}: ${e.value}')
              .join(', ')
              : data['errors']?.toString()) ??
          defaultMessage;
    } else if (data is String) {
      errorMessage = data;
    }

    return Exception(errorMessage);
  }
}
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
//
// import '../../../../../core/constants/api_endpoints.dart';
// import '../model/blog_model.dart';
//
// class BlogRepository {
//   final Dio _dio;
//
//   BlogRepository(this._dio);
//
//   /// ✅ Upload image to server and return image URL
//   Future<String> uploadImage(File imageFile) async {
//     try {
//       debugPrint('📸 === UPLOAD IMAGE REQUEST ===');
//       debugPrint('File path: ${imageFile.path}');
//       debugPrint('File size: ${imageFile.lengthSync()} bytes');
//
//       // Create FormData for multipart/form-data request
//       final formData = FormData.fromMap({
//         'image': await MultipartFile.fromFile(
//           imageFile.path,
//           filename: imageFile.path.split('/').last,
//         ),
//       });
//
//       debugPrint('🌐 Calling API: ${ApiPath.baseUrl}/upload'); // Adjust endpoint as needed
//
//       final response = await _dio.post(
//         '${ApiPath.baseUrl}/upload', // ✅ Change to your actual image upload endpoint
//         data: formData,
//         options: Options(
//           contentType: 'multipart/form-data',
//           headers: {
//             'Accept': 'application/json',
//           },
//         ),
//       );
//
//       debugPrint('✅ Upload response status: ${response.statusCode}');
//       debugPrint('✅ Upload response data: ${response.data}');
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final responseData = response.data;
//
//         // Extract image URL from response
//         // Adjust the key names based on your backend response structure
//         String? imageUrl;
//
//         if (responseData is Map<String, dynamic>) {
//           imageUrl = responseData['imageUrl']?.toString() ??
//               responseData['url']?.toString() ??
//               responseData['image']?.toString();
//
//           // If nested under 'data' key
//           if (imageUrl == null && responseData['data'] is Map) {
//             final dataMap = responseData['data'] as Map<String, dynamic>;
//             imageUrl = dataMap['imageUrl']?.toString() ??
//                 dataMap['url']?.toString();
//           }
//         }
//
//         if (imageUrl != null && imageUrl.isNotEmpty) {
//           debugPrint('✅ Image URL obtained: $imageUrl');
//           return imageUrl;
//         } else {
//           throw Exception('No image URL in response');
//         }
//       }
//
//       throw Exception(
//         'Failed to upload image: ${response.statusCode} ${response.statusMessage}',
//       );
//     } on DioException catch (e) {
//       debugPrint('❌ DioException on uploadImage: ${e.message}');
//       if (e.response != null) {
//         debugPrint('❌ Response status: ${e.response?.statusCode}');
//         debugPrint('❌ Response data: ${e.response?.data}');
//
//         String errorMessage = 'Failed to upload image';
//         final data = e.response?.data;
//
//         if (data is Map) {
//           if (data['message'] != null) {
//             errorMessage = data['message'].toString();
//           } else if (data['error'] != null) {
//             errorMessage = data['error'].toString();
//           }
//         } else if (data is String) {
//           errorMessage = data;
//         }
//
//         throw Exception(errorMessage);
//       } else {
//         throw Exception('Network error: ${e.message ?? "No connection"}');
//       }
//     } catch (e) {
//       debugPrint('❌ Unexpected error on uploadImage: $e');
//       throw Exception('Error uploading image: $e');
//     }
//   }
//
//   /// Create a new blog post
//   Future<BlogModel> createBlog({
//     required String title,
//     required String content,
//     required List<String> tags,
//     String? imageUrl,
//   }) async {
//     try {
//       debugPrint('📤 === CREATE BLOG REQUEST ===');
//       debugPrint('Title: $title');
//       debugPrint('Content length: ${content.length}');
//       debugPrint('Tags: $tags');
//       debugPrint('ImageUrl: $imageUrl');
//
//       final data = <String, dynamic>{
//         'title': title,
//         'content': content,
//         'tags': tags,
//         if (imageUrl != null && imageUrl.isNotEmpty) 'imageUrl': imageUrl,
//       };
//
//       debugPrint('🌐 Calling API: ${ApiPath.baseUrl}${ApiPath.postBlog}');
//
//       final response = await _dio.post(
//         '${ApiPath.baseUrl}${ApiPath.postBlog}',
//         data: data,
//         options: Options(
//           headers: const {
//             'Content-Type': 'application/json',
//           },
//         ),
//       );
//
//       debugPrint('✅ Blog response status: ${response.statusCode}');
//       debugPrint('✅ Blog response data: ${response.data}');
//
//       if (response.statusCode == 200 ||
//           response.statusCode == 201 ||
//           response.statusCode == 204) {
//         final responseData = response.data;
//         if (responseData is Map<String, dynamic>) {
//           // Some APIs wrap data under "data"
//           final blogJson =
//               (responseData['data'] as Map<String, dynamic>?) ?? responseData;
//           return BlogModel.fromJson(blogJson);
//         } else {
//           // Fallback empty model when API doesn't return body
//           return BlogModel(
//             id: '',
//             title: title,
//             content: content,
//             tags: tags,
//             imageUrl: imageUrl,
//           );
//         }
//       }
//
//       throw Exception(
//         'Failed to create blog: ${response.statusCode} ${response.statusMessage}',
//       );
//     } on DioException catch (e) {
//       debugPrint('❌ DioException on createBlog: ${e.message}');
//       if (e.response != null) {
//         debugPrint('❌ Response status: ${e.response?.statusCode}');
//         debugPrint('❌ Response data: ${e.response?.data}');
//
//         String errorMessage = 'Failed to create blog';
//         final data = e.response?.data;
//
//         if (data is Map) {
//           if (data['message'] != null) {
//             errorMessage = data['message'].toString();
//           } else if (data['error'] != null) {
//             errorMessage = data['error'].toString();
//           } else if (data['errors'] != null) {
//             errorMessage = data['errors'].toString();
//           }
//         } else if (data is String) {
//           errorMessage = data;
//         }
//
//         throw Exception(errorMessage);
//       } else {
//         throw Exception('Network error: ${e.message ?? "No connection"}');
//       }
//     } catch (e) {
//       debugPrint('❌ Unexpected error on createBlog: $e');
//       throw Exception('Error creating blog: $e');
//     }
//   }
//
//   /// Fetch list of blogs
//   Future<List<BlogModel>> fetchBlogs() async {
//     try {
//       debugPrint('🌐 Fetching blogs: ${ApiPath.baseUrl}${ApiPath.postBlog}');
//
//       final response = await _dio.get(
//         '${ApiPath.baseUrl}${ApiPath.postBlog}',
//       );
//
//       debugPrint('✅ Fetch blogs status: ${response.statusCode}');
//       debugPrint('✅ Fetch blogs data: ${response.data}');
//
//       if (response.statusCode == 200) {
//         final data = response.data;
//
//         // Handle common API shapes:
//         // 1) { data: [...] }
//         // 2) [...]
//         final listJson = data is Map<String, dynamic>
//             ? (data['data'] as List<dynamic>? ?? data['blogs'] as List<dynamic>?)
//             : data as List<dynamic>?;
//
//         if (listJson == null) {
//           return const [];
//         }
//
//         return listJson
//             .map((e) => BlogModel.fromJson(e as Map<String, dynamic>))
//             .toList();
//       }
//
//       throw Exception(
//         'Failed to fetch blogs: ${response.statusCode} ${response.statusMessage}',
//       );
//     } on DioException catch (e) {
//       debugPrint('❌ DioException on fetchBlogs: ${e.message}');
//       if (e.response != null) {
//         debugPrint('❌ Response status: ${e.response?.statusCode}');
//         debugPrint('❌ Response data: ${e.response?.data}');
//
//         String errorMessage = 'Failed to fetch blogs';
//         final data = e.response?.data;
//
//         if (data is Map) {
//           if (data['message'] != null) {
//             errorMessage = data['message'].toString();
//           } else if (data['error'] != null) {
//             errorMessage = data['error'].toString();
//           } else if (data['errors'] != null) {
//             errorMessage = data['errors'].toString();
//           }
//         } else if (data is String) {
//           errorMessage = data;
//         }
//
//         throw Exception(errorMessage);
//       } else {
//         throw Exception('Network error: ${e.message ?? "No connection"}');
//       }
//     } catch (e) {
//       debugPrint('❌ Unexpected error on fetchBlogs: $e');
//       throw Exception('Error fetching blogs: $e');
//     }
//   }
//
// }
