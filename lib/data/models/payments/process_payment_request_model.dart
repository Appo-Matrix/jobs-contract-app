class ProcessPaymentRequestModel {
  final String userId;
  final String paymentMethodId;
  final int amount;

  ProcessPaymentRequestModel({
    required this.userId,
    required this.paymentMethodId,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'paymentMethodId': paymentMethodId,
      'amount': amount,
    };
  }
}
