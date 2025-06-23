class GoogleSignInRequest {
  final String email;
  final String name;
  final String photo;

  GoogleSignInRequest({
    required this.email,
    required this.name,
    required this.photo,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'photo': photo,
  };
}
