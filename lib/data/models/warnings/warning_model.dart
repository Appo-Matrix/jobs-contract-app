class WarningModel {
  final String id;
  final String reason;
  final DateTime createdAt;
  final UserModel user;

  WarningModel({
    required this.id,
    required this.reason,
    required this.createdAt,
    required this.user,
  });

  factory WarningModel.fromJson(Map<String, dynamic> json) {
    return WarningModel(
      id: json['_id'],
      reason: json['reason'],
      createdAt: DateTime.parse(json['createdAt']),
      user: UserModel.fromJson(json['userId']),
    );
  }
}

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }
}
