// data/models/location_model.dart
class LocationModel {
  final String? userId;
  final String city;
  final String state;
  final double lat;
  final double lng;

  LocationModel({
    this.userId,
    required this.city,
    required this.state,
    required this.lat,
    required this.lng,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      userId: json['userId'],
      city: json['city'],
      state: json['state'],
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "city": city,
      "state": state,
      "lat": lat,
      "lng": lng,
    };
  }
}
