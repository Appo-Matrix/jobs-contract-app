class StartFreeTrialResponse {
  final bool success;
  final SubscriptionData? subscription;

  StartFreeTrialResponse({
    required this.success,
    this.subscription,
  });

  factory StartFreeTrialResponse.fromJson(Map<String, dynamic> json) {
    return StartFreeTrialResponse(
      success: json['success'] ?? false,
      subscription: json['subscription'] != null
          ? SubscriptionData.fromJson(json['subscription'])
          : null,
    );
  }
}

class SubscriptionData {
  final String id;
  final String userId;
  final String plan;
  final DateTime endDate;

  SubscriptionData({
    required this.id,
    required this.userId,
    required this.plan,
    required this.endDate,
  });

  factory SubscriptionData.fromJson(Map<String, dynamic> json) {
    return SubscriptionData(
      id: json['_id'],
      userId: json['userId'],
      plan: json['plan'],
      endDate: DateTime.parse(json['endDate']),
    );
  }
}
