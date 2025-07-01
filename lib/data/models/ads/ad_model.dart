// models/ads/ad_model.dart

class AdModel {
  final String id;
  final String title;
  final String description;
  final String image;
  final String video;
  final int price;

  AdModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.video,
    required this.price,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      video: json['video'] ?? '',
      price: json['price'] ?? 0,
    );
  }
}
