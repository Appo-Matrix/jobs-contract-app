class LoginResponse {
  final String token;
  final User user;

  LoginResponse({
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String profile;
  final String bio;
  final String country;
  final String dob;
  final String phoneNumber;
  final bool isVerified;
  final bool isBlocked;
  final bool isIdentityVerified;
  final List<String> skills;
  final List<String> languages;
  final List<String> education;
  final List<String> workExperience;
  final int earning;
  final String title;
  final String userType;
  final bool isOnline;
  final String stripeAccountId;
  final String stripeCustomerId;
  final int unreadNotificationsCount;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profile,
    required this.bio,
    required this.country,
    required this.dob,
    required this.phoneNumber,
    required this.isVerified,
    required this.isBlocked,
    required this.isIdentityVerified,
    required this.skills,
    required this.languages,
    required this.education,
    required this.workExperience,
    required this.earning,
    required this.title,
    required this.userType,
    required this.isOnline,
    required this.stripeAccountId,
    required this.stripeCustomerId,
    required this.unreadNotificationsCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      profile: json['profile'],
      bio: json['bio'],
      country: json['country'],
      dob: json['dob'],
      phoneNumber: json['phoneNumber'],
      isVerified: json['isVerified'],
      isBlocked: json['isBlocked'],
      isIdentityVerified: json['isIdentityVerified'],
      skills: List<String>.from(json['skills']),
      languages: List<String>.from(json['languages']),
      education: List<String>.from(json['education']),
      workExperience: List<String>.from(json['workExperience']),
      earning: json['earning'],
      title: json['title'],
      userType: json['userType'],
      isOnline: json['isOnline'],
      stripeAccountId: json['stripeAccountId'],
      stripeCustomerId: json['stripeCustomerId'],
      unreadNotificationsCount: json['unreadNotificationsCount'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
