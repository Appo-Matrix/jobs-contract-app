class CancelSubscriptionRequest {
  final String userId;

  CancelSubscriptionRequest({required this.userId});

  Map<String, dynamic> toJson() => {
    'userId': userId,
  };
}
