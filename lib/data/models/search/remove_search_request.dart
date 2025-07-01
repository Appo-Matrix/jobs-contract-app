// remove_search_request.dart
class RemoveSearchRequest {
  final String userId;
  final String search;

  RemoveSearchRequest({required this.userId, required this.search});

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "search": search,
  };
}
