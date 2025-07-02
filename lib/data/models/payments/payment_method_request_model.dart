class PaymentMethodRequestModel {
  final String userId;
  final String paymentMethodId;

  PaymentMethodRequestModel({
    required this.userId,
    required this.paymentMethodId,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'paymentMethodId': paymentMethodId,
    };
  }
}
