// data/models/ads/ad_detail_model.dart

class AdDetailModel {
  final String id;
  final String title;
  final String description;
  final String image;
  final String? video;
  final int price;
  final String userId;
  final Map<String, dynamic> location;

  AdDetailModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    this.video,
    required this.price,
    required this.userId,
    required this.location,
  });

  factory AdDetailModel.fromJson(Map<String, dynamic> json) {
    return AdDetailModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      video: json['video'],
      price: json['price'],
      userId: json['userId'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'image': image,
      'video': video,
      'price': price,
      'userId': userId,
      'location': location,
    };
  }
}
