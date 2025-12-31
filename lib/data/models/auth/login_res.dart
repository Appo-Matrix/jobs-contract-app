class LoginResponse {
  final String token;
  final User user;

  LoginResponse({
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] as String? ?? '',
      user: User.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user.toJson(),
    };
  }
}

class User {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String userType;
  final String serviceRange;
  final int earning;
  final int yearsOfExperience;
  final bool isVerified;
  final bool isBlocked;
  final bool isIdentityVerified;
  final bool agreeToPrivacy;
  final bool infoConsent;
  final bool isOnline;
  final bool isPhoneVerified;
  final bool isEmailVerified;
  final bool isFeatured;

  // Optional/Empty string fields
  final String profile;
  final String businessName;
  final String bio;
  final String country;
  final String dob;
  final String phoneOTP;
  final String emailOTP;
  final String socketId;
  final String password;
  final String streetAndNumber;
  final String neighbourhoodArea;
  final String stateOrProvince;
  final String city;
  final String postalCode;
  final String serviceType;
  final String specialty;
  final String title;
  final String establishedYear;
  final String companyType;
  final String licenseNumber;
  final String stripeAccountId;
  final String stripeCustomerId;

  // Collections
  final List<dynamic> skills;
  final List<dynamic> languages;
  final List<dynamic> education;
  final List<dynamic> workExperience;
  final List<dynamic> certificates;

  // Nested objects
  final Identity identity;
  final Location location;

  // Metadata
  final int unreadNotificationsCount;
  final String createdAt;
  final String updatedAt;
  final int v;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    required this.serviceRange,
    required this.earning,
    required this.yearsOfExperience,
    required this.isVerified,
    required this.isBlocked,
    required this.isIdentityVerified,
    required this.agreeToPrivacy,
    required this.infoConsent,
    required this.isOnline,
    required this.isPhoneVerified,
    required this.isEmailVerified,
    required this.isFeatured,
    required this.profile,
    required this.businessName,
    required this.bio,
    required this.country,
    required this.dob,
    required this.phoneOTP,
    required this.emailOTP,
    required this.socketId,
    required this.password,
    required this.streetAndNumber,
    required this.neighbourhoodArea,
    required this.stateOrProvince,
    required this.city,
    required this.postalCode,
    required this.serviceType,
    required this.specialty,
    required this.title,
    required this.establishedYear,
    required this.companyType,
    required this.licenseNumber,
    required this.stripeAccountId,
    required this.stripeCustomerId,
    required this.skills,
    required this.languages,
    required this.education,
    required this.workExperience,
    required this.certificates,
    required this.identity,
    required this.location,
    required this.unreadNotificationsCount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      userType: json['userType'] as String? ?? '',
      serviceRange: json['serviceRange'] as String? ?? '',
      earning: json['earning'] as int? ?? 0,
      yearsOfExperience: json['yearsOfExperience'] as int? ?? 0,
      isVerified: json['isVerified'] as bool? ?? false,
      isBlocked: json['isBlocked'] as bool? ?? false,
      isIdentityVerified: json['isIdentityVerified'] as bool? ?? false,
      agreeToPrivacy: json['agreeToPrivacy'] as bool? ?? false,
      infoConsent: json['infoConsent'] as bool? ?? false,
      isOnline: json['isOnline'] as bool? ?? false,
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      isFeatured: json['isFeatured'] as bool? ?? false,
      profile: json['profile'] as String? ?? '',
      businessName: json['businessName'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      country: json['country'] as String? ?? '',
      dob: json['dob'] as String? ?? '',
      phoneOTP: json['phoneOTP'] as String? ?? '',
      emailOTP: json['emailOTP'] as String? ?? '',
      socketId: json['socketId'] as String? ?? '',
      password: json['password'] as String? ?? '',
      streetAndNumber: json['streetAndNumber'] as String? ?? '',
      neighbourhoodArea: json['neighbourhoodArea'] as String? ?? '',
      stateOrProvince: json['stateOrProvince'] as String? ?? '',
      city: json['city'] as String? ?? '',
      postalCode: json['postalCode'] as String? ?? '',
      serviceType: json['serviceType'] as String? ?? '',
      specialty: json['specialty'] as String? ?? '',
      title: json['title'] as String? ?? '',
      establishedYear: json['establishedYear'] as String? ?? '',
      companyType: json['companyType'] as String? ?? '',
      licenseNumber: json['licenseNumber'] as String? ?? '',
      stripeAccountId: json['stripeAccountId'] as String? ?? '',
      stripeCustomerId: json['stripeCustomerId'] as String? ?? '',
      skills: json['skills'] as List<dynamic>? ?? [],
      languages: json['languages'] as List<dynamic>? ?? [],
      education: json['education'] as List<dynamic>? ?? [],
      workExperience: json['workExperience'] as List<dynamic>? ?? [],
      certificates: json['certificates'] as List<dynamic>? ?? [],
      identity: json['identity'] != null
          ? Identity.fromJson(json['identity'] as Map<String, dynamic>)
          : Identity(nic: '', passport: ''),
      location: json['location'] != null
          ? Location.fromJson(json['location'] as Map<String, dynamic>)
          : Location(type: 'Point', coordinates: []),
      unreadNotificationsCount: json['unreadNotificationsCount'] as int? ?? 0,
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      v: json['__v'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'userType': userType,
      'serviceRange': serviceRange,
      'earning': earning,
      'yearsOfExperience': yearsOfExperience,
      'isVerified': isVerified,
      'isBlocked': isBlocked,
      'isIdentityVerified': isIdentityVerified,
      'agreeToPrivacy': agreeToPrivacy,
      'infoConsent': infoConsent,
      'isOnline': isOnline,
      'isPhoneVerified': isPhoneVerified,
      'isEmailVerified': isEmailVerified,
      'isFeatured': isFeatured,
      'profile': profile,
      'businessName': businessName,
      'bio': bio,
      'country': country,
      'dob': dob,
      'phoneOTP': phoneOTP,
      'emailOTP': emailOTP,
      'socketId': socketId,
      'password': password,
      'streetAndNumber': streetAndNumber,
      'neighbourhoodArea': neighbourhoodArea,
      'stateOrProvince': stateOrProvince,
      'city': city,
      'postalCode': postalCode,
      'serviceType': serviceType,
      'specialty': specialty,
      'title': title,
      'establishedYear': establishedYear,
      'companyType': companyType,
      'licenseNumber': licenseNumber,
      'stripeAccountId': stripeAccountId,
      'stripeCustomerId': stripeCustomerId,
      'skills': skills,
      'languages': languages,
      'education': education,
      'workExperience': workExperience,
      'certificates': certificates,
      'identity': identity.toJson(),
      'location': location.toJson(),
      'unreadNotificationsCount': unreadNotificationsCount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class Identity {
  final String nic;
  final String passport;

  Identity({
    required this.nic,
    required this.passport,
  });

  factory Identity.fromJson(Map<String, dynamic> json) {
    return Identity(
      nic: json['NIC'] as String? ?? '',
      passport: json['passport'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'NIC': nic,
      'passport': passport,
    };
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] as String? ?? 'Point',
      coordinates: List<double>.from(
        (json['coordinates'] as List<dynamic>? ?? [])
            .map((e) => (e as num).toDouble()),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

// class LoginResponse {
//   final String token;
//   final User user;
//
//   LoginResponse({
//     required this.token,
//     required this.user,
//   });
//
//   factory LoginResponse.fromJson(Map<String, dynamic> json) {
//     return LoginResponse(
//       token: json['token'],
//       user: User.fromJson(json['user']),
//     );
//   }
// }
//
// class User {
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String profile;
//   final String bio;
//   final String country;
//   final String dob;
//   final String phoneNumber;
//   final bool isVerified;
//   final bool isBlocked;
//   final bool isIdentityVerified;
//   final List<String> skills;
//   final List<String> languages;
//   final List<String> education;
//   final List<String> workExperience;
//   final int earning;
//   final String title;
//   final String userType;
//   final bool isOnline;
//   final String stripeAccountId;
//   final String stripeCustomerId;
//   final int unreadNotificationsCount;
//   final String createdAt;
//   final String updatedAt;
//
//   User({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.profile,
//     required this.bio,
//     required this.country,
//     required this.dob,
//     required this.phoneNumber,
//     required this.isVerified,
//     required this.isBlocked,
//     required this.isIdentityVerified,
//     required this.skills,
//     required this.languages,
//     required this.education,
//     required this.workExperience,
//     required this.earning,
//     required this.title,
//     required this.userType,
//     required this.isOnline,
//     required this.stripeAccountId,
//     required this.stripeCustomerId,
//     required this.unreadNotificationsCount,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['_id'],
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//       email: json['email'],
//       profile: json['profile'],
//       bio: json['bio'],
//       country: json['country'],
//       dob: json['dob'],
//       phoneNumber: json['phoneNumber'],
//       isVerified: json['isVerified'],
//       isBlocked: json['isBlocked'],
//       isIdentityVerified: json['isIdentityVerified'],
//       skills: List<String>.from(json['skills']),
//       languages: List<String>.from(json['languages']),
//       education: List<String>.from(json['education']),
//       workExperience: List<String>.from(json['workExperience']),
//       earning: json['earning'],
//       title: json['title'],
//       userType: json['userType'],
//       isOnline: json['isOnline'],
//       stripeAccountId: json['stripeAccountId'],
//       stripeCustomerId: json['stripeCustomerId'],
//       unreadNotificationsCount: json['unreadNotificationsCount'],
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//     );
//   }
// }
