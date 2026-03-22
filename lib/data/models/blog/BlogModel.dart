class BlogModel {
  final String id;
  final String authorId;
  final String title;
  final String content;
  final String image;
  final List<String> tags;
  final bool isPublished;
  final BlogVisibility visibility;
  final String createdAt;
  final String updatedAt;

  BlogModel({
    required this.id,
    required this.authorId,
    required this.title,
    required this.content,
    required this.image,
    required this.tags,
    required this.isPublished,
    required this.visibility,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['_id']?.toString() ?? '',
      authorId: json['authorId']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      isPublished: json['isPublished'] ?? false,
      visibility: BlogVisibility.fromJson(
        json['visibility'] ?? {},
      ),
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'authorId': authorId,
    'title': title,
    'content': content,
    'image': image,
    'tags': tags,
    'isPublished': isPublished,
    'visibility': visibility.toJson(),
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}

class BlogVisibility {
  final bool public;
  final bool private;

  BlogVisibility({required this.public, required this.private});

  factory BlogVisibility.fromJson(Map<String, dynamic> json) {
    return BlogVisibility(
      public: json['public'] ?? true,
      private: json['private'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'public': public,
    'private': private,
  };
}