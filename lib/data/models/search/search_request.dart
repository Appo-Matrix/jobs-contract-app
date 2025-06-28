// search_request.dart
class SearchRequest {
  final String category;
  final String location;
  final String serviceType;
  final String search;

  SearchRequest({
    required this.category,
    required this.location,
    required this.serviceType,
    required this.search,
  });

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'location': location,
      'serviceType': serviceType,
      'search': search,
    };
  }
}
