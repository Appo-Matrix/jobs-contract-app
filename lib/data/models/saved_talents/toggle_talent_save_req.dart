class ToggleTalentSaveRequest {
  final String clientId;
  final String talentId;

  ToggleTalentSaveRequest({required this.clientId, required this.talentId});

  Map<String, dynamic> toJson() => {
    'clientId': clientId,
    'talentId': talentId,
  };
}
