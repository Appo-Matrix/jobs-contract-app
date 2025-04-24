

class Ad {
  final String id;
  final String title;
  final double price;
  final String category;
  final String imageUrl;
  final String? description;
  final String? location;
  final DateTime? postedDate;

  Ad({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.imageUrl,
    this.description,
    this.location,
    this.postedDate,
  });

  // You can add methods to convert to/from JSON here
  // This would be useful when working with API responses

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      category: json['category'],

      imageUrl: json['imageUrl'],
      description: json['description'],
      location: json['location'],
      postedDate: json['postedDate'] != null
          ? DateTime.parse(json['postedDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'description': description,
      'location': location,
      'postedDate': postedDate?.toIso8601String(),
    };
  }
}