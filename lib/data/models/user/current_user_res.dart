class CurrentUser {
  final String? id;
  final String? name;
  final String? email;
  final String? profile;
  final String? bio;
  final String? country;
  final String? dob;
  final String? phoneNumber;
  final bool? isVerified;
  final bool? isBlocked;
  final bool? isIdentityVerified;
  final int? earning;
  final String? title;
  final List<Language>? languages;
  final List<Skill>? skills;
  final List<Education>? education;
  final List<WorkHistory>? workHistory;

  CurrentUser({
    this.id,
    this.name,
    this.email,
    this.profile,
    this.bio,
    this.country,
    this.dob,
    this.phoneNumber,
    this.isVerified,
    this.isBlocked,
    this.isIdentityVerified,
    this.earning,
    this.title,
    this.languages,
    this.skills,
    this.education,
    this.workHistory,
  });

  factory CurrentUser.fromJson(Map<String, dynamic> json) {
    return CurrentUser(
      id: json['_id'] as String?,
      name: json['fullName'] as String? ?? json['name'] as String?,
      email: json['email'] as String?,
      profile: json['profile'] as String?,
      bio: json['bio'] as String?,
      country: json['country'] as String?,
      dob: json['dob'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
      isBlocked: json['isBlocked'] as bool? ?? false,
      isIdentityVerified: json['isIdentityVerified'] as bool? ?? false,
      earning: json['earning'] as int?,
      title: json['title'] as String?,
      languages: json['languages'] != null && (json['languages'] as List).isNotEmpty
          ? (json['languages'] as List)
          .map((e) => Language.fromJson(e as Map<String, dynamic>))
          .toList()
          : [],
      skills: json['skills'] != null && (json['skills'] as List).isNotEmpty
          ? (json['skills'] as List)
          .map((e) => Skill.fromJson(e as Map<String, dynamic>))
          .toList()
          : [],
      education: json['education'] != null && (json['education'] as List).isNotEmpty
          ? (json['education'] as List)
          .map((e) => Education.fromJson(e as Map<String, dynamic>))
          .toList()
          : [],
      workHistory: json['workHistory'] != null && (json['workHistory'] as List).isNotEmpty
          ? (json['workHistory'] as List)
          .map((e) => WorkHistory.fromJson(e as Map<String, dynamic>))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': name,
      'email': email,
      'profile': profile,
      'bio': bio,
      'country': country,
      'dob': dob,
      'phoneNumber': phoneNumber,
      'isVerified': isVerified,
      'isBlocked': isBlocked,
      'isIdentityVerified': isIdentityVerified,
      'earning': earning,
      'title': title,
      'languages': languages?.map((e) => e.toJson()).toList(),
      'skills': skills?.map((e) => e.toJson()).toList(),
      'education': education?.map((e) => e.toJson()).toList(),
      'workHistory': workHistory?.map((e) => e.toJson()).toList(),
    };
  }
}

class Language {
  final String name;
  final String proficiency;

  Language({required this.name, required this.proficiency});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      name: json['name'] as String? ?? '',
      proficiency: json['proficiency'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'proficiency': proficiency,
    };
  }
}

class Skill {
  final String name;

  Skill({required this.name});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(name: json['name'] as String? ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}

class Education {
  final String institution;
  final String? startDate;
  final String? endDate;

  Education({
    required this.institution,
    this.startDate,
    this.endDate,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      institution: json['institution'] as String? ?? '',
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'institution': institution,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}

class WorkHistory {
  final String organization;
  final String position;
  final String? startDate;
  final String? endDate;

  WorkHistory({
    required this.organization,
    required this.position,
    this.startDate,
    this.endDate,
  });

  factory WorkHistory.fromJson(Map<String, dynamic> json) {
    return WorkHistory(
      organization: json['organization'] as String? ?? '',
      position: json['position'] as String? ?? '',
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'organization': organization,
      'position': position,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}

// class CurrentUser {
//   final String? id;
//   final String? name;
//   final String? email;
//   final String? profile;
//   final String? bio;
//   final String? country;
//   final String? dob;
//   final String? phoneNumber;
//   final bool? isVerified;
//   final bool? isBlocked;
//   final bool? isIdentityVerified;
//   final int? earning;
//   final String? title;
//   final List<Language>? languages;
//   final List<Skill>? skills;
//   final List<Education>? education;
//   final List<WorkHistory>? workHistory;
//
//   CurrentUser({
//      this.id,
//      this.name,
//      this.email,
//     this.profile,
//     this.bio,
//     this.country,
//     this.dob,
//     this.phoneNumber,
//      this.isVerified,
//      this.isBlocked,
//      this.isIdentityVerified,
//     this.earning,
//     this.title,
//      this.languages,
//      this.skills,
//      this.education,
//      this.workHistory,
//   });
//
//   factory CurrentUser.fromJson(Map<String, dynamic> json) {
//     return CurrentUser(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       email: json['email'] ?? '',
//       profile: json['profile'],
//       bio: json['bio'],
//       country: json['country'],
//       dob: json['dob'],
//       phoneNumber: json['phoneNumber'],
//       isVerified: json['isVerified'] ?? false,
//       isBlocked: json['isBlocked'] ?? false,
//       isIdentityVerified: json['isIdentityVerified'] ?? false,
//       earning: json['earning'],
//       title: json['title'],
//       languages: (json['languages'] as List)
//           .map((e) => Language.fromJson(e))
//           .toList(),
//       skills:
//       (json['skills'] as List).map((e) => Skill.fromJson(e)).toList(),
//       education: (json['education'] as List)
//           .map((e) => Education.fromJson(e))
//           .toList(),
//       workHistory: (json['workHistory'] as List)
//           .map((e) => WorkHistory.fromJson(e))
//           .toList(),
//     );
//   }
// }
//
// class Language {
//   final String name;
//   final String proficiency;
//
//   Language({required this.name, required this.proficiency});
//
//   factory Language.fromJson(Map<String, dynamic> json) {
//     return Language(
//       name: json['name'] ?? '',
//       proficiency: json['proficiency'] ?? '',
//     );
//   }
// }
//
// class Skill {
//   final String name;
//
//   Skill({required this.name});
//
//   factory Skill.fromJson(Map<String, dynamic> json) {
//     return Skill(name: json['name'] ?? '');
//   }
// }
//
// class Education {
//   final String institution;
//   final String? startDate;
//   final String? endDate;
//
//   Education({
//     required this.institution,
//     this.startDate,
//     this.endDate,
//   });
//
//   factory Education.fromJson(Map<String, dynamic> json) {
//     return Education(
//       institution: json['institution'] ?? '',
//       startDate: json['startDate'],
//       endDate: json['endDate'],
//     );
//   }
// }
//
// class WorkHistory {
//   final String organization;
//   final String position;
//   final String? startDate;
//   final String? endDate;
//
//   WorkHistory({
//     required this.organization,
//     required this.position,
//     this.startDate,
//     this.endDate,
//   });
//
//   factory WorkHistory.fromJson(Map<String, dynamic> json) {
//     return WorkHistory(
//       organization: json['organization'] ?? '',
//       position: json['position'] ?? '',
//       startDate: json['startDate'],
//       endDate: json['endDate'],
//     );
//   }
// }
