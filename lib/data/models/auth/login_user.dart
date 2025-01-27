class LoginUser {
  int id;
  String email;

  LoginUser({
    required this.id,
    required this.email,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(
      id: json['id'],
      email: json['email'] != null ? json['email'] as String : '',
    );
  }
}