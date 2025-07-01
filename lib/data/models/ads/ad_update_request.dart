// data/models/ads/ad_update_request.dart

class AdUpdateRequest {
  final String title;
  final String description;
  final int price;
  final String category;
  final String status;

  AdUpdateRequest({
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'category': category,
      'status': status,
    };
  }
}
