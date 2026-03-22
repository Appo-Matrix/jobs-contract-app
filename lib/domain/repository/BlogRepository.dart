import '../../../../data/models/blog/BlogModel.dart';
import '../../../../data/models/blog/CreateBlogRequest.dart';

abstract class BlogRepository {
  Future<BlogModel> createBlog(CreateBlogRequest request);
  Future<List<BlogModel>> getAllBlogs();
  Future<List<BlogModel>> getBlogsByUser(String userId);
}