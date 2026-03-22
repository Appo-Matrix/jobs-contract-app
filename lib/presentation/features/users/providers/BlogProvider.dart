  import 'package:flutter/material.dart';
  import 'package:fluttertoast/fluttertoast.dart';

  import '../../../../data/models/blog/BlogModel.dart';
  import '../../../../data/models/blog/CreateBlogRequest.dart';
  import '../../../../data/repositories/BlogRepositoryImpl.dart';
  import '../../../../domain/repository/BlogRepository.dart';


  class BlogProvider with ChangeNotifier {
    final BlogRepository _repository = BlogRepositoryImpl();

    // ── State ──────────────────────────────────────────────────────────────────

    bool _isLoading = false;
    bool _isCreating = false;
    String? _errorMessage;

    List<BlogModel> _blogs = [];
    List<BlogModel> _myBlogs = [];
    BlogModel? _createdBlog;

    // ── Getters ────────────────────────────────────────────────────────────────

    bool get isLoading => _isLoading;
    bool get isCreating => _isCreating;
    String? get errorMessage => _errorMessage;
    List<BlogModel> get blogs => _blogs;
    List<BlogModel> get myBlogs => _myBlogs;
    BlogModel? get createdBlog => _createdBlog;

    // ── Create Blog ────────────────────────────────────────────────────────────

    Future<bool> createBlog(CreateBlogRequest request) async {
      _isCreating = true;
      _errorMessage = null;
      notifyListeners();

      try {
        _createdBlog = await _repository.createBlog(request);

        // Optimistically add to top of both lists
        _blogs.insert(0, _createdBlog!);
        _myBlogs.insert(0, _createdBlog!);

        Fluttertoast.showToast(msg: 'Blog created successfully');
        notifyListeners();
        return true;
      } catch (e) {
        _errorMessage = e.toString();
        Fluttertoast.showToast(msg: _errorMessage!);
        notifyListeners();
        return false;
      } finally {
        _isCreating = false;
        notifyListeners();
      }
    }

    // ── Fetch All Blogs ────────────────────────────────────────────────────────

    Future<void> fetchBlogs() async {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      try {
        _blogs = await _repository.getAllBlogs();
      } catch (e) {
        _errorMessage = e.toString();
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }

    // ── Fetch My Blogs ─────────────────────────────────────────────────────────

    Future<void> fetchMyBlogs(String userId) async {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      try {
        _myBlogs = await _repository.getBlogsByUser(userId);
      } catch (e) {
        _errorMessage = e.toString();
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }

    // ── Utility ────────────────────────────────────────────────────────────────

    void clearError() {
      _errorMessage = null;
      notifyListeners();
    }
  }