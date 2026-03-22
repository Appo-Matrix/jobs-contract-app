import 'package:flutter/foundation.dart';
import '../../../../domain/repository/BlogRepository.dart';
import '../../../../data/models/blog/BlogModel.dart';
import '../../../../data/models/blog/CreateBlogRequest.dart';
import '../data_source/remote/blog_rds.dart';

class BlogRepositoryImpl extends BlogRepository {
  final BlogRemoteDataSource _remote = BlogRemoteDataSource();

  // ── Create Blog ────────────────────────────────────────────────────────────
  @override
  Future<BlogModel> createBlog(CreateBlogRequest request) async {
    try {
      debugPrint('📤 Creating blog: ${request.title}');
      final blog = await _remote.createBlog(request);
      debugPrint('✅ Blog created: ${blog.id}');
      return blog;
    } catch (e) {
      debugPrint('❌ Error creating blog: $e');
      rethrow;
    }
  }

  // ── Fetch All Blogs ────────────────────────────────────────────────────────
  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      debugPrint('📥 Fetching all blogs...');
      final blogs = await _remote.getAllBlogs();
      debugPrint('✅ Fetched ${blogs.length} blogs');
      return blogs;
    } catch (e) {
      debugPrint('❌ Error fetching blogs: $e');
      rethrow;
    }
  }

  // ── Fetch Blogs by User ────────────────────────────────────────────────────
  @override
  Future<List<BlogModel>> getBlogsByUser(String userId) async {
    try {
      debugPrint('📥 Fetching blogs for user: $userId');
      final blogs = await _remote.getBlogsByUser(userId);
      debugPrint('✅ Fetched ${blogs.length} user blogs');
      return blogs;
    } catch (e) {
      debugPrint('❌ Error fetching user blogs: $e');
      rethrow;
    }
  }
}