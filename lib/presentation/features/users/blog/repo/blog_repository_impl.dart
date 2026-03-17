import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/constants/api_endpoints.dart';
import '../model/blog_model.dart';
import 'blog_repository.dart';

/// NOTE: You only need this file if you are using the interface+impl pattern.
/// If you are using BlogRepository directly (single concrete class),
/// DELETE this file and remove all references to BlogRepositoryImpl.
class BlogRepositoryImpl extends BlogRepository {
  BlogRepositoryImpl(super.dio);

  @override
  Future<String> uploadImage(File imageFile) async {
    throw UnimplementedError('Use createBlogWithImage instead');
  }

  /// ✅ Create blog WITH image as multipart/form-data (ONE REQUEST)
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

      // ✅ Bracket notation: tags[0]=flutter, tags[1]=dart
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

      throw Exception('Failed to create blog: ${response.statusCode}');
    } on DioException catch (e) {
      debugPrint('❌ DioException: ${e.message}');
      _logDioError(e);
      throw _handleDioException(e, 'Failed to create blog with image');
    } catch (e) {
      throw Exception('Error creating blog with image: $e');
    }
  }

  @override
  Future<BlogModel> createBlog({
    required String title,
    required String content,
    required List<String> tags,
    String? imageUrl,
  }) async {
    try {
      final payload = <String, dynamic>{
        'title': title,
        'content': content,
        'tags': tags,
        if (imageUrl != null && imageUrl.isNotEmpty) 'imageUrl': imageUrl,
      };

      final response = await dio.post(
        '${ApiPath.baseUrl}${ApiPath.postBlog}',
        data: payload,
        options: Options(headers: const {'Content-Type': 'application/json'}),
      );

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
      throw Exception('Failed to create blog: ${response.statusCode}');
    } on DioException catch (e) {
      _logDioError(e);
      throw _handleDioException(e, 'Failed to create blog');
    } catch (e) {
      throw Exception('Error creating blog: $e');
    }
  }

  @override
  Future<List<BlogModel>> fetchBlogs() async {
    try {
      final response =
      await dio.get('${ApiPath.baseUrl}${ApiPath.postBlog}');

      if (response.statusCode == 200) {
        return _parseBlogsResponse(response.data);
      }
      throw Exception('Failed to fetch blogs: ${response.statusCode}');
    } on DioException catch (e) {
      _logDioError(e);
      throw _handleDioException(e, 'Failed to fetch blogs');
    } catch (e) {
      throw Exception('Error fetching blogs: $e');
    }
  }

  /// ✅ FIXED: signature now matches BlogRepository.fetchMyBlogs({required String userId})
  @override
  Future<List<BlogModel>> fetchMyBlogs({required String userId}) async {
    try {
      final url = '${ApiPath.baseUrl}${ApiPath.getBlogByUser}/$userId';
      debugPrint('🔄 === FETCH MY BLOGS ===');
      debugPrint('🌐 Calling API: $url');

      final response = await dio.get(
        url,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      debugPrint('✅ Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final blogs = _parseBlogsResponse(response.data);
        debugPrint('✅ Loaded ${blogs.length} user blogs');
        return blogs;
      }
      throw Exception('Failed to fetch my blogs: ${response.statusCode}');
    } on DioException catch (e) {
      debugPrint('❌ DioException: ${e.message}');
      _logDioError(e);
      throw _handleDioException(e, 'Failed to fetch my blogs');
    } catch (e) {
      throw Exception('Error fetching my blogs: $e');
    }
  }

  // ============================================================================
  // PRIVATE HELPERS
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

  void _logDioError(DioException e) {
    if (e.response != null) {
      debugPrint('❌ Status: ${e.response?.statusCode}');
      debugPrint('❌ Data: ${e.response?.data}');
    }
  }
}

// import 'dart:convert';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
//
// import '../../../../../core/constants/api_endpoints.dart';
// import '../model/blog_model.dart';
// import 'blog_repository.dart';
//
// /// Concrete implementation of BlogRepository using Dio for HTTP requests
// class BlogRepositoryImpl implements BlogRepository {
//   final Dio _dio;
//
//   BlogRepositoryImpl(this._dio);
//
//   @override
//   Future<String> uploadImage(File imageFile) async {
//     throw UnimplementedError('Use createBlogWithImage instead');
//   }
//
//   /// ✅ Create blog with image as multipart/form-data (ONE REQUEST)
//   ///
//   /// Tags are sent using bracket notation: tags[0]=flutter&tags[1]=dart
//   /// This is the most widely supported array format for multipart forms
//   /// (used by Express/Multer, NestJS, Laravel, etc.)
//   Future<BlogModel> createBlogWithImage({
//     required String title,
//     required String content,
//     required List<String> tags,
//     required File imageFile,
//   }) async {
//     try {
//       debugPrint('📤 === CREATE BLOG WITH IMAGE (ONE REQUEST) ===');
//       debugPrint('Title: $title');
//       debugPrint('Content: $content');
//       debugPrint('Tags: $tags');
//       debugPrint('Image file: ${imageFile.path}');
//       debugPrint('File size: ${imageFile.lengthSync()} bytes');
//
//       final formData = FormData();
//
//       // ✅ Basic fields
//       formData.fields.add(MapEntry('title', title));
//       formData.fields.add(MapEntry('content', content));
//
//       // ✅ Send tags using bracket notation: tags[0]=flutter, tags[1]=dart
//       // This is the standard way most Node.js/Express servers parse arrays
//       // from multipart form data
//       for (int i = 0; i < tags.length; i++) {
//         formData.fields.add(MapEntry('tags[$i]', tags[i]));
//       }
//
//       // ✅ Image file
//       formData.files.add(
//         MapEntry(
//           'image',
//           await MultipartFile.fromFile(
//             imageFile.path,
//             filename: imageFile.path.split('/').last,
//           ),
//         ),
//       );
//
//       debugPrint('🌐 Calling API: ${ApiPath.baseUrl}${ApiPath.postBlog}');
//       debugPrint('📋 FormData fields sent:');
//       debugPrint('   - title: "$title"');
//       debugPrint('   - content: "$content"');
//       for (int i = 0; i < tags.length; i++) {
//         debugPrint('   - tags[$i]: "${tags[i]}"');
//       }
//       debugPrint('   - image: ${imageFile.path.split('/').last}');
//
//       final response = await _dio.post(
//         '${ApiPath.baseUrl}${ApiPath.postBlog}',
//         data: formData,
//         options: Options(
//           contentType: 'multipart/form-data',
//           headers: {
//             'Accept': 'application/json',
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
//         return _parseBlogResponse(
//           response.data,
//           fallback: BlogModel(
//             id: '',
//             title: title,
//             content: content,
//             tags: tags,
//           ),
//         );
//       }
//
//       throw Exception('Failed to create blog: ${response.statusCode}');
//     } on DioException catch (e) {
//       debugPrint('❌ DioException on createBlogWithImage: ${e.message}');
//       _logDioError(e);
//       throw _handleDioException(e, 'Failed to create blog with image');
//     } catch (e) {
//       debugPrint('❌ Unexpected error on createBlogWithImage: $e');
//       throw Exception('Error creating blog with image: $e');
//     }
//   }
//
//   /// Create a blog post without image (JSON body)
//   @override
//   Future<BlogModel> createBlog({
//     required String title,
//     required String content,
//     required List<String> tags,
//     String? imageUrl,
//   }) async {
//     try {
//       debugPrint('📝 === CREATE BLOG REQUEST (JSON) ===');
//
//       final payload = <String, dynamic>{
//         'title': title,
//         'content': content,
//         'tags': tags, // ✅ Plain List<String> — Dio sends as proper JSON array
//         if (imageUrl != null && imageUrl.isNotEmpty) 'imageUrl': imageUrl,
//       };
//
//       debugPrint('🌐 Calling API: ${ApiPath.baseUrl}${ApiPath.postBlog}');
//
//       final response = await _dio.post(
//         '${ApiPath.baseUrl}${ApiPath.postBlog}',
//         data: payload,
//         options: Options(
//           headers: const {
//             'Content-Type': 'application/json',
//           },
//         ),
//       );
//
//       debugPrint('✅ Blog response status: ${response.statusCode}');
//
//       if (response.statusCode == 200 ||
//           response.statusCode == 201 ||
//           response.statusCode == 204) {
//         return _parseBlogResponse(
//           response.data,
//           fallback: BlogModel(
//             id: '',
//             title: title,
//             content: content,
//             tags: tags,
//             imageUrl: imageUrl,
//           ),
//         );
//       }
//
//       throw Exception('Failed to create blog: ${response.statusCode}');
//     } on DioException catch (e) {
//       debugPrint('❌ DioException on createBlog: ${e.message}');
//       _logDioError(e);
//       throw _handleDioException(e, 'Failed to create blog');
//     } catch (e) {
//       debugPrint('❌ Unexpected error on createBlog: $e');
//       throw Exception('Error creating blog: $e');
//     }
//   }
//
//   /// Fetch all blog posts
//   @override
//   Future<List<BlogModel>> fetchBlogs() async {
//     try {
//       debugPrint('🔄 === FETCH BLOGS REQUEST ===');
//       debugPrint('🌐 Calling API: ${ApiPath.baseUrl}${ApiPath.postBlog}');
//
//       final response = await _dio.get(
//         '${ApiPath.baseUrl}${ApiPath.postBlog}',
//       );
//
//       if (response.statusCode == 200) {
//         final blogs = _parseBlogsResponse(response.data);
//         debugPrint('✅ Loaded ${blogs.length} blogs');
//         return blogs;
//       }
//
//       throw Exception('Failed to fetch blogs: ${response.statusCode}');
//     } on DioException catch (e) {
//       debugPrint('❌ DioException on fetchBlogs: ${e.message}');
//       _logDioError(e);
//       throw _handleDioException(e, 'Failed to fetch blogs');
//     } catch (e) {
//       debugPrint('❌ Unexpected error on fetchBlogs: $e');
//       throw Exception('Error fetching blogs: $e');
//     }
//   }
//
//   // ============================================================================
//   // PRIVATE HELPERS
//   // ============================================================================
//
//   BlogModel _parseBlogResponse(
//       dynamic responseData, {
//         BlogModel? fallback,
//       }) {
//     if (responseData is Map<String, dynamic>) {
//       final blogJson =
//           (responseData['data'] as Map<String, dynamic>?) ?? responseData;
//       return BlogModel.fromJson(blogJson);
//     }
//     if (fallback != null) return fallback;
//     throw Exception('Invalid response format');
//   }
//
//   List<BlogModel> _parseBlogsResponse(dynamic responseData) {
//     List<dynamic>? listJson;
//
//     if (responseData is Map<String, dynamic>) {
//       listJson = (responseData['data'] as List<dynamic>?) ??
//           (responseData['blogs'] as List<dynamic>?);
//     } else if (responseData is List<dynamic>) {
//       listJson = responseData;
//     }
//
//     if (listJson == null) return const [];
//
//     return listJson
//         .map((e) => BlogModel.fromJson(e as Map<String, dynamic>))
//         .toList();
//   }
//
//   Exception _handleDioException(DioException e, String defaultMessage) {
//     if (e.response == null) {
//       return Exception('Network error: ${e.message ?? "No connection"}');
//     }
//
//     String errorMessage = defaultMessage;
//     final data = e.response?.data;
//
//     if (data is Map) {
//       if (data['message'] != null) {
//         errorMessage = data['message'].toString();
//       } else if (data['error'] != null) {
//         errorMessage = data['error'].toString();
//       } else if (data['errors'] != null) {
//         final errors = data['errors'];
//         if (errors is Map) {
//           errorMessage =
//               errors.entries.map((e) => '${e.key}: ${e.value}').join(', ');
//         } else {
//           errorMessage = errors.toString();
//         }
//       }
//     } else if (data is String) {
//       errorMessage = data;
//     }
//
//     return Exception(errorMessage);
//   }
//
//   void _logDioError(DioException e) {
//     if (e.response != null) {
//       debugPrint('❌ Status: ${e.response?.statusCode}');
//       debugPrint('❌ Data: ${e.response?.data}');
//     }
//   }
// }
