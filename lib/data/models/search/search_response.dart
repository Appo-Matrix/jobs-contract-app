// search_response.dart
class SearchResponse {
  final bool success;
  final String message;
  final int? count;
  final int? page;
  final int? totalPages;
  final int? totalResults;
  final List<SearchResultItem> data;

  SearchResponse({
    required this.success,
    required this.message,
    this.count,
    this.page,
    this.totalPages,
    this.totalResults,
    required this.data,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      count: json['count'],
      page: json['page'],
      totalPages: json['totalPages'],
      totalResults: json['totalResults'],
      data: (json['data'] as List)
          .map((item) => SearchResultItem.fromJson(item))
          .toList(),
    );
  }
}

class SearchResultItem {
  final String id;
  final String name;
  final String email;
  final String category;
  final String serviceType;
  final String city;
  final String stateOrProvince;

  SearchResultItem({
    required this.id,
    required this.name,
    required this.email,
    required this.category,
    required this.serviceType,
    required this.city,
    required this.stateOrProvince,
  });

  factory SearchResultItem.fromJson(Map<String, dynamic> json) {
    return SearchResultItem(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      category: json['category'],
      serviceType: json['serviceType'],
      city: json['city'],
      stateOrProvince: json['stateOrProvince'],
    );
  }
}
