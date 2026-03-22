import 'dart:io';
import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../../data/models/blog/BlogModel.dart';
import '../../../data/models/blog/CreateBlogRequest.dart';

class BlogRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);

  // ── Create Blog (multipart/form-data) ──────────────────────────────────────
  Future<BlogModel> createBlog(CreateBlogRequest request) async {
    // ✅ Tags must be sent as repeated fields: tags[0]=ios&tags[1]=react
    // FormData.fromMap with a List does this correctly only when using
    // ListFormat.multiCompatible — build manually to be safe
    final formData = FormData();

    formData.fields.add(MapEntry('authorId', request.authorId));
    formData.fields.add(MapEntry('title', request.title));
    formData.fields.add(MapEntry('content', request.content));

    // ✅ Add each tag as a separate field entry
    for (final tag in request.tags) {
      formData.fields.add(MapEntry('tags', tag));
    }

    // ✅ Add image only if selected
    if (request.image != null && request.image!.existsSync()) {
      formData.files.add(
        MapEntry(
          'image',
          await MultipartFile.fromFile(
            request.image!.path,
            filename: request.image!.path.split('/').last,
          ),
        ),
      );
    }

    final response = await apiClient.postMultipart(
      endpoint: ApiPath.createBlog,
      data: formData,
    );

    switch (response.statusCode) {
      case 200:
      case 201:
        return BlogModel.fromJson(response.data['data']);
      case 400:
      // ✅ Show actual validation errors from API
        final errors = response.data['errors'];
        final message = errors != null
            ? errors.values.join(', ')
            : response.data['message'] ?? 'Bad request';
        throw Exception(message);
      case 401:
        throw Exception('Unauthorized — please login again');
      case 500:
        throw Exception(response.data['error'] ?? 'Internal server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  // ── Fetch All Blogs ────────────────────────────────────────────────────────
  Future<List<BlogModel>> getAllBlogs() async {
    final response = await apiClient.get(ApiPath.getAllBlogs);

    switch (response.statusCode) {
      case 200:
        final raw = response.data;
        final List data = raw is Map ? (raw['data'] ?? []) : raw;
        return data.map((e) => BlogModel.fromJson(e)).toList();
      case 401:
        throw Exception('Unauthorized — please login again');
      case 500:
        throw Exception(response.data['error'] ?? 'Internal server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  // ── Fetch Blogs by User ID ─────────────────────────────────────────────────
  Future<List<BlogModel>> getBlogsByUser(String userId) async {
    final response = await apiClient.get(ApiPath.getBlogsByUser(userId));

    switch (response.statusCode) {
      case 200:
        final raw = response.data;
        final List data = raw is Map ? (raw['data'] ?? []) : raw;
        return data.map((e) => BlogModel.fromJson(e)).toList();
      case 404:
        throw Exception('No blogs found for this user');
      case 500:
        throw Exception('Internal server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }
}