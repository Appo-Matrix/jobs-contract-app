class CreatePaymentIntentRequestModel {
  final int amount;
  final String currency;

  CreatePaymentIntentRequestModel({
    required this.amount,
    required this.currency,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }
}
