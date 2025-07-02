class CancelSubscriptionResponse {
  final bool success;
  final String message;
  final SubscriptionData? data;

  CancelSubscriptionResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory CancelSubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return CancelSubscriptionResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? SubscriptionData.fromJson(json['data']) : null,
    );
  }
}

class SubscriptionData {
  final String id;
  final String userId;
  final String plan;
  final DateTime startDate;
  final DateTime endDate;

  SubscriptionData({
    required this.id,
    required this.userId,
    required this.plan,
    required this.startDate,
    required this.endDate,
  });

  factory SubscriptionData.fromJson(Map<String, dynamic> json) {
    return SubscriptionData(
      id: json['_id'],
      userId: json['userId'],
      plan: json['plan'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }
}
