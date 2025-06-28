class CurrentUser {
  final String id;
  final String name;
  final String email;
  final String? profile;
  final String? bio;
  final String? country;
  final String? dob;
  final String? phoneNumber;
  final bool isVerified;
  final bool isBlocked;
  final bool isIdentityVerified;
  final int? earning;
  final String? title;
  final List<Language> languages;
  final List<Skill> skills;
  final List<Education> education;
  final List<WorkHistory> workHistory;

  CurrentUser({
    required this.id,
    required this.name,
    required this.email,
    this.profile,
    this.bio,
    this.country,
    this.dob,
    this.phoneNumber,
    required this.isVerified,
    required this.isBlocked,
    required this.isIdentityVerified,
    this.earning,
    this.title,
    required this.languages,
    required this.skills,
    required this.education,
    required this.workHistory,
  });

  factory CurrentUser.fromJson(Map<String, dynamic> json) {
    return CurrentUser(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profile: json['profile'],
      bio: json['bio'],
      country: json['country'],
      dob: json['dob'],
      phoneNumber: json['phoneNumber'],
      isVerified: json['isVerified'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
      isIdentityVerified: json['isIdentityVerified'] ?? false,
      earning: json['earning'],
      title: json['title'],
      languages: (json['languages'] as List)
          .map((e) => Language.fromJson(e))
          .toList(),
      skills:
      (json['skills'] as List).map((e) => Skill.fromJson(e)).toList(),
      education: (json['education'] as List)
          .map((e) => Education.fromJson(e))
          .toList(),
      workHistory: (json['workHistory'] as List)
          .map((e) => WorkHistory.fromJson(e))
          .toList(),
    );
  }
}

class Language {
  final String name;
  final String proficiency;

  Language({required this.name, required this.proficiency});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      name: json['name'] ?? '',
      proficiency: json['proficiency'] ?? '',
    );
  }
}

class Skill {
  final String name;

  Skill({required this.name});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(name: json['name'] ?? '');
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
      institution: json['institution'] ?? '',
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
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
      organization: json['organization'] ?? '',
      position: json['position'] ?? '',
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }
}
