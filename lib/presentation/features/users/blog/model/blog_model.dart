class BlogModel {
  final String id;
  final String title;
  final String content;
  final List<String> tags;
  final String? imageUrl;
  final DateTime? createdAt;

  BlogModel({
    required this.id,
    required this.title,
    required this.content,
    required this.tags,
    this.imageUrl,
    this.createdAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['_id']?.toString() ??
          json['id']?.toString() ??
          '', // backend id key may vary
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString() ?? json['body']?.toString() ?? '',
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      imageUrl: json['imageUrl']?.toString() ?? json['image']?.toString(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'tags': tags,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }
}