import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../../../../core/services/auth_service.dart';
import '../model/blog_model.dart';
import '../repo/blog_repository.dart';

class BlogProvider extends ChangeNotifier {
  final BlogRepository _repository;
  final AuthService _authService;

  BlogProvider(this._repository, this._authService);

  // ============================================================================
  // State Variables
  // ============================================================================

  bool _isLoading = false;
  String? _errorMessage;
  BlogModel? _lastCreatedBlog;
  final List<BlogModel> _blogs = [];

  bool _isLoadingMyBlogs = false;
  String? _myBlogsError;
  final List<BlogModel> _myBlogs = [];

  // ============================================================================
  // Getters
  // ============================================================================

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  BlogModel? get lastCreatedBlog => _lastCreatedBlog;
  List<BlogModel> get blogs => List.unmodifiable(_blogs);

  bool get isLoadingMyBlogs => _isLoadingMyBlogs;
  String? get myBlogsError => _myBlogsError;
  List<BlogModel> get myBlogs => List.unmodifiable(_myBlogs);

  // ============================================================================
  // Private: Get current user ID from AuthService
  // ============================================================================

  /// Reads stored user JSON from SharedPreferences via AuthService
  /// and extracts the MongoDB _id field.
  Future<String> _getCurrentUserId() async {
    final userData = await _authService.getUserData();

    if (userData == null || userData.isEmpty) {
      throw Exception('User not logged in. Please login again.');
    }

    try {
      final userJson = jsonDecode(userData) as Map<String, dynamic>;

      // Try common MongoDB ID field names
      final userId = userJson['_id']?.toString() ??
          userJson['id']?.toString() ??
          userJson['userId']?.toString();

      if (userId == null || userId.isEmpty) {
        debugPrint('❌ User JSON keys available: ${userJson.keys.toList()}');
        throw Exception('User ID not found in stored user data.');
      }

      debugPrint('✅ Current user ID: $userId');
      return userId;
    } catch (e) {
      if (e.toString().contains('User ID not found') ||
          e.toString().contains('User not logged in')) {
        rethrow;
      }
      throw Exception('Failed to parse user data: $e');
    }
  }

  // ============================================================================
  // Create Blog Methods
  // ============================================================================

  /// Create a blog post WITH image (multipart/form-data)
  Future<bool> createBlogWithImage({
    required String title,
    required String content,
    required List<String> tags,
    File? imageFile,
  }) async {
    if (_isLoading) {
      debugPrint('⚠️ Already loading, ignoring request');
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      debugPrint('🎯 === CREATE BLOG WITH IMAGE ===');
      debugPrint('Title: $title | Tags: $tags | Image: ${imageFile?.path}');

      if (imageFile == null || !imageFile.existsSync()) {
        throw Exception('Image file not found');
      }

      final blog = await _repository.createBlogWithImage(
        title: title,
        content: content,
        tags: tags,
        imageFile: imageFile,
      );

      _lastCreatedBlog = blog;
      _myBlogs.insert(0, blog);

      debugPrint('✅ Blog created: ${blog.id}');
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('❌ createBlogWithImage error: $e');
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Create a blog post WITHOUT image (JSON body)
  Future<bool> createBlog({
    required String title,
    required String content,
    required List<String> tags,
    String? imageUrl,
  }) async {
    if (_isLoading) {
      debugPrint('⚠️ Already loading, ignoring request');
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      debugPrint('📝 === CREATE BLOG (WITHOUT IMAGE) ===');

      final blog = await _repository.createBlog(
        title: title,
        content: content,
        tags: tags,
        imageUrl: imageUrl,
      );

      _lastCreatedBlog = blog;
      _myBlogs.insert(0, blog);

      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('❌ createBlog error: $e');
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ============================================================================
  // Fetch Methods
  // ============================================================================

  /// ✅ Load blogs created by the currently authenticated user
  ///
  /// Calls GET /api/v1/blogs/user/{userId}
  /// userId is read from stored user JSON in SharedPreferences via AuthService
  Future<void> loadMyBlogs() async {
    if (_isLoadingMyBlogs) {
      debugPrint('⚠️ Already loading my blogs, ignoring');
      return;
    }

    _isLoadingMyBlogs = true;
    _myBlogsError = null;
    notifyListeners();

    try {
      // ✅ Step 1: get userId from stored auth data
      final userId = await _getCurrentUserId();

      debugPrint('🔄 Loading my blogs for userId: $userId');

      // ✅ Step 2: pass userId — this was the missing argument causing the error
      final results = await _repository.fetchMyBlogs(userId: userId);

      _myBlogs
        ..clear()
        ..addAll(results);

      debugPrint('✅ Loaded ${results.length} user blogs');
      notifyListeners();
    } catch (e) {
      _myBlogsError = e.toString();
      debugPrint('❌ loadMyBlogs error: $e');
      notifyListeners();
    } finally {
      _isLoadingMyBlogs = false;
      notifyListeners();
    }
  }

  /// Load all public blog posts
  Future<void> loadBlogs() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      debugPrint('🔄 Loading all blogs...');
      final results = await _repository.fetchBlogs();

      _blogs
        ..clear()
        ..addAll(results);

      debugPrint('✅ Loaded ${results.length} blogs');
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('❌ loadBlogs error: $e');
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ============================================================================
  // Utility Methods
  // ============================================================================

  /// Remove a blog from myBlogs list by ID (optimistic delete)
  void removeMyBlogById(String id) {
    _myBlogs.removeWhere((blog) => blog.id == id);
    notifyListeners();
  }

  /// Clear all error messages
  void clearError() {
    _errorMessage = null;
    _myBlogsError = null;
    notifyListeners();
  }
}


// import 'dart:io';
// import 'package:flutter/foundation.dart';
//
// import '../model/blog_model.dart';
// import '../repo/blog_repository.dart';
//
// /// Blog Provider - State Management
// ///
// /// Creates blog with image by sending everything together
// /// to /api/v1/blogs/ as multipart/form-data
// class BlogProvider extends ChangeNotifier {
//   final BlogRepository _repository;
//
//   BlogProvider(this._repository);
//
//   // ============================================================================
//   // State Variables
//   // ============================================================================
//
//   bool _isLoading = false;
//   String? _errorMessage;
//   BlogModel? _lastCreatedBlog;
//   final List<BlogModel> _blogs = [];
//
//   // ============================================================================
//   // Getters
//   // ============================================================================
//
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   BlogModel? get lastCreatedBlog => _lastCreatedBlog;
//   List<BlogModel> get blogs => List.unmodifiable(_blogs);
//
//   // ============================================================================
//   // Public Methods
//   // ============================================================================
//
//   /// Create a blog post with image
//   ///
//   /// Sends title, content, tags, and image file together
//   /// to /api/v1/blogs/ as multipart/form-data
//   ///
//   /// Parameters:
//   ///   - [title]: Blog title (required)
//   ///   - [content]: Blog content (required)
//   ///   - [tags]: List of tags (required)
//   ///   - [imageFile]: Image file from gallery (optional)
//   ///
//   /// Returns:
//   ///   true if successful, false otherwise
//   Future<bool> createBlogWithImage({
//     required String title,
//     required String content,
//     required List<String> tags,
//     File? imageFile,
//   }) async {
//     if (_isLoading) {
//       debugPrint('⚠️ Already loading, ignoring request');
//       return false;
//     }
//
//     _setLoading(true);
//     _errorMessage = null;
//
//     try {
//       debugPrint('🎯 === CREATE BLOG WITH IMAGE ===');
//       debugPrint('Title: $title');
//       debugPrint('Content: $content');
//       debugPrint('Tags: $tags');
//       debugPrint('Image: ${imageFile?.path}');
//
//       // ✅ Check if image file exists
//       if (imageFile == null || !imageFile.existsSync()) {
//         throw Exception('Image file not found');
//       }
//
//       // ✅ Call repository method to create blog with image
//       // This sends everything as multipart/form-data
//       final blog = await (_repository as dynamic).createBlogWithImage(
//         title: title,
//         content: content,
//         tags: tags,
//         imageFile: imageFile,
//       );
//
//       _lastCreatedBlog = blog;
//       debugPrint('✅ Blog created successfully');
//       debugPrint('📍 Blog ID: ${blog.id}');
//
//       notifyListeners();
//       return true;
//     } catch (e) {
//       _errorMessage = e.toString();
//       debugPrint('❌ Error in createBlogWithImage: $e');
//       notifyListeners();
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   /// Create a blog post with optional image URL
//   ///
//   /// Use this when you already have an image URL
//   ///
//   /// Parameters:
//   ///   - [title]: Blog title (required)
//   ///   - [content]: Blog content (required)
//   ///   - [tags]: List of tags (required)
//   ///   - [imageUrl]: Image URL (optional)
//   ///
//   /// Returns:
//   ///   true if successful, false otherwise
//   Future<bool> createBlog({
//     required String title,
//     required String content,
//     required List<String> tags,
//     String? imageUrl,
//   }) async {
//     if (_isLoading) {
//       debugPrint('⚠️ Already loading, ignoring request');
//       return false;
//     }
//
//     _setLoading(true);
//     _errorMessage = null;
//
//     try {
//       debugPrint('📝 === CREATE BLOG (WITHOUT IMAGE) ===');
//       debugPrint('Title: $title');
//       debugPrint('Content: $content');
//       debugPrint('Tags: $tags');
//
//       final blog = await _repository.createBlog(
//         title: title,
//         content: content,
//         tags: tags,
//         imageUrl: imageUrl,
//       );
//
//       _lastCreatedBlog = blog;
//       debugPrint('✅ Blog created successfully');
//
//       notifyListeners();
//       return true;
//     } catch (e) {
//       _errorMessage = e.toString();
//       debugPrint('❌ Error in createBlog: $e');
//       notifyListeners();
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   /// Load all blog posts
//   Future<void> loadBlogs() async {
//     _setLoading(true);
//     _errorMessage = null;
//
//     try {
//       debugPrint('🔄 Loading blogs...');
//       final results = await _repository.fetchBlogs();
//
//       _blogs
//         ..clear()
//         ..addAll(results);
//
//       debugPrint('✅ Loaded ${results.length} blogs');
//       notifyListeners();
//     } catch (e) {
//       _errorMessage = e.toString();
//       debugPrint('❌ Error loading blogs: $e');
//       notifyListeners();
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   /// Clear error message
//   void clearError() {
//     _errorMessage = null;
//     notifyListeners();
//   }
//
//   // ============================================================================
//   // Private Methods
//   // ============================================================================
//
//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }
// }