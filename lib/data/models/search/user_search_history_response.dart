// user_search_history_response.dart
class UserSearchHistoryItem {
  final String userId;
  final String search;
  final DateTime createdAt;

  UserSearchHistoryItem({
    required this.userId,
    required this.search,
    required this.createdAt,
  });

  factory UserSearchHistoryItem.fromJson(Map<String, dynamic> json) {
    return UserSearchHistoryItem(
      userId: json['userId'],
      search: json['search'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
