class SetDefaultPaymentMethodRequestModel {
  final String userId;
  final String paymentMethodId;

  SetDefaultPaymentMethodRequestModel({
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
