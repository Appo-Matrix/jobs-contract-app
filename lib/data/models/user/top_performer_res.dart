class TopPerformer {
  final String id;
  final String firstName;
  final String lastName;
  final String profile;
  final double earning;
  final int acceptedOffers;

  TopPerformer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profile,
    required this.earning,
    required this.acceptedOffers,
  });

  factory TopPerformer.fromJson(Map<String, dynamic> json) {
    return TopPerformer(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profile: json['profile'] ?? '',
      earning: (json['earning'] ?? 0).toDouble(),
      acceptedOffers: json['acceptedOffers'] ?? 0,
    );
  }
}
