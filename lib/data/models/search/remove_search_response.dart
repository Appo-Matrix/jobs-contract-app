// remove_search_response.dart
class RemoveSearchResponse {
  final String message;

  RemoveSearchResponse({required this.message});

  factory RemoveSearchResponse.fromJson(Map<String, dynamic> json) {
    return RemoveSearchResponse(
      message: json['message'] ?? '',
    );
  }
}
