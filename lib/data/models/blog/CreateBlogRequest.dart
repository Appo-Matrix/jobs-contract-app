import 'dart:io';

class CreateBlogRequest {
  final String authorId;
  final String title;
  final String content;
  final List<String> tags;
  final File? image; // null = no image upload

  CreateBlogRequest({
    required this.authorId,
    required this.title,
    required this.content,
    required this.tags,
    this.image,
  });

  /// Converts to Map for multipart/form-data.
  /// Tags are sent as repeated fields: tags=ios&tags=react&...
  Map<String, dynamic> toFormDataMap() => {
    'authorId': authorId,
    'title': title,
    'content': content,
    'tags': tags, // ApiClient should handle List as repeated fields
  };
}