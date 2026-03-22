import 'login_res.dart';

class GoogleSignInResponse {
  final bool success;
  final String message;
  final String accessToken;
  final GoogleUser user;

  GoogleSignInResponse({
    required this.success,
    required this.message,
    required this.accessToken,
    required this.user,
  });

  factory GoogleSignInResponse.fromJson(Map<String, dynamic> json) {
    return GoogleSignInResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      accessToken: json['accessToken'] ?? '',
      user: GoogleUser.fromJson(json['user'] ?? {}),
    );
  }
}
//
// class GoogleUser {
//   final String id;
//   final String email;
//   final String firstName;
//   final String profilePicture;
//
//   GoogleUser({
//     required this.id,
//     required this.email,
//     required this.firstName,
//     required this.profilePicture,
//   });
//
//   factory GoogleUser.fromJson(Map<String, dynamic> json) {
//     return GoogleUser(
//       id: json['_id'] ?? '',
//       email: json['email'] ?? '',
//       firstName: json['firstName'] ?? '',
//       profilePicture: json['profilePicture'] ?? '',
//     );
//   }
// }



class GoogleUser {
  final String id;
  final String email;
  final String firstName;
  final String profilePicture;

  GoogleUser({
    required this.id,
    required this.email,
    required this.firstName,
    required this.profilePicture,
  });

  factory GoogleUser.fromJson(Map<String, dynamic> json) {
    return GoogleUser(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
    );
  }

  // ── Convert to User for AuthPreferences ───────────────────────────────────
  User toUser() {
    return User(
      id: id,
      email: email,
      fullName: firstName,
      profile: profilePicture,
      // ── required fields defaulted ─────────────────────────────────────────
      phoneNumber: '',
      userType: '',
      serviceRange: '',
      earning: 0,
      yearsOfExperience: 0,
      isVerified: false,
      isBlocked: false,
      isIdentityVerified: false,
      agreeToPrivacy: false,
      infoConsent: false,
      isOnline: false,
      isPhoneVerified: false,
      isEmailVerified: false,
      isFeatured: false,
      businessName: '',
      bio: '',
      country: '',
      dob: '',
      phoneOTP: '',
      emailOTP: '',
      socketId: '',
      password: '',
      streetAndNumber: '',
      neighbourhoodArea: '',
      stateOrProvince: '',
      city: '',
      postalCode: '',
      serviceType: '',
      specialty: '',
      title: '',
      establishedYear: '',
      companyType: '',
      licenseNumber: '',
      stripeAccountId: '',
      stripeCustomerId: '',
      skills: [],
      languages: [],
      education: [],
      workExperience: [],
      certificates: [],
      identity: Identity(nic: '', passport: ''),
      location: Location(type: 'Point', coordinates: []),
      unreadNotificationsCount: 0,
      createdAt: '',
      updatedAt: '',
      v: 0,
    );
  }
}