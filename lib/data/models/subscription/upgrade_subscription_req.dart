class UpgradeSubscriptionRequest {
  final String userId;
  final String plan;
  final String paymentMethodId;

  UpgradeSubscriptionRequest({
    required this.userId,
    required this.plan,
    required this.paymentMethodId,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'plan': plan,
    'paymentMethodId': paymentMethodId,
  };
}
