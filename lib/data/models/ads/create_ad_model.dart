// models/ads/create_ad_model.dart

class CreateAdModel {
  final String userId;
  final String title;
  final String description;
  final String image;
  final String video;
  final int price;
  final Location location;

  CreateAdModel({
    required this.userId,
    required this.title,
    required this.description,
    required this.image,
    required this.video,
    required this.price,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "title": title,
      "description": description,
      "image": image,
      "video": video,
      "price": price,
      "location": location.toJson(),
    };
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({required this.type, required this.coordinates});

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates,
  };
}
