class PaymentIntent {
  final String id;
  final String status;

  PaymentIntent({required this.id, required this.status});

  factory PaymentIntent.fromJson(Map<String, dynamic> json) {
    return PaymentIntent(
      id: json['id'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class ProcessPaymentResponseModel {
  final String message;
  final PaymentIntent paymentIntent;

  ProcessPaymentResponseModel({
    required this.message,
    required this.paymentIntent,
  });

  factory ProcessPaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return ProcessPaymentResponseModel(
      message: json['message'] ?? '',
      paymentIntent: PaymentIntent.fromJson(json['paymentIntent']),
    );
  }
}
