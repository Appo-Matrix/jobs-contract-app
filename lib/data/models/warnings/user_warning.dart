class UserWarning {
  final String id;
  final String reason;
  final DateTime createdAt;
  final UserInfo user;

  UserWarning({
    required this.id,
    required this.reason,
    required this.createdAt,
    required this.user,
  });

  factory UserWarning.fromJson(Map<String, dynamic> json) {
    return UserWarning(
      id: json['_id'],
      reason: json['reason'],
      createdAt: DateTime.parse(json['createdAt']),
      user: UserInfo.fromJson(json['userId']),
    );
  }
}

class UserInfo {
  final String id;
  final String name;
  final String email;

  UserInfo({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
