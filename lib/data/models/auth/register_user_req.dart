class RegisterUserRequest {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String userType;
  final String password;
  final Location location;

  RegisterUserRequest({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    required this.password,
    required this.location,
  });

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'phoneNumber': phoneNumber,
    'userType': userType,
    'password': password,
    'location': location.toJson(),
  };
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({required this.type, required this.coordinates});

  Map<String, dynamic> toJson() => {
    'type': type,
    'coordinates': coordinates,
  };
}
