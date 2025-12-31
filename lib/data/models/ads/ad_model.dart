// models/ads/ad_model.dart

class AdModel {
  final String id;
  final String title;
  final String description;
  final List<String> images;
  final List<String> videos;
  final int price;
  final String category;
  final String status;
  final String userId;
  final DateTime createdAt;

  AdModel({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.videos,
    required this.price,
    required this.category,
    required this.status,
    required this.userId,
    required this.createdAt,
  });

  // Get first image or placeholder
  String get image {
    return images.isNotEmpty ? images[0] : '';
  }

  // Get first video
  String get video {
    return videos.isNotEmpty ? videos[0] : '';
  }

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      videos: List<String>.from(json['videos'] ?? []),
      price: json['price'] ?? 0,
      category: json['category'] ?? '',
      status: json['status'] ?? '',
      userId: json['userId'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'images': images,
      'videos': videos,
      'price': price,
      'category': category,
      'status': status,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}