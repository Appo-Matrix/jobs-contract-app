class SavedTalentsResponse {
  final bool success;
  final String message;
  final List<SavedTalent> data;

  SavedTalentsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SavedTalentsResponse.fromJson(Map<String, dynamic> json) {
    return SavedTalentsResponse(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => SavedTalent.fromJson(item))
          .toList(),
    );
  }
}

class SavedTalent {
  final String id;
  final String clientId;
  final Talent talent;

  SavedTalent({
    required this.id,
    required this.clientId,
    required this.talent,
  });

  factory SavedTalent.fromJson(Map<String, dynamic> json) {
    return SavedTalent(
      id: json['_id'],
      clientId: json['clientId'],
      talent: Talent.fromJson(json['talentId']),
    );
  }
}

class Talent {
  final String id;
  final String name;
  final String email;
  final String profilePicture;

  Talent({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePicture,
  });

  factory Talent.fromJson(Map<String, dynamic> json) {
    return Talent(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      profilePicture: json['profilePicture'],
    );
  }
}
