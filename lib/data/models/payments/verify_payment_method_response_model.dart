class VerifiedPaymentMethod {
  final String type;
  final String last4;
  final int expMonth;
  final int expYear;
  final String status;

  VerifiedPaymentMethod({
    required this.type,
    required this.last4,
    required this.expMonth,
    required this.expYear,
    required this.status,
  });

  factory VerifiedPaymentMethod.fromJson(Map<String, dynamic> json) {
    return VerifiedPaymentMethod(
      type: json['type'] ?? '',
      last4: json['last4'] ?? '',
      expMonth: json['exp_month'] ?? 0,
      expYear: json['exp_year'] ?? 0,
      status: json['status'] ?? '',
    );
  }
}

class VerifyPaymentMethodResponseModel {
  final String message;
  final VerifiedPaymentMethod paymentMethod;

  VerifyPaymentMethodResponseModel({
    required this.message,
    required this.paymentMethod,
  });

  factory VerifyPaymentMethodResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyPaymentMethodResponseModel(
      message: json['message'] ?? '',
      paymentMethod: VerifiedPaymentMethod.fromJson(json['paymentMethod']),
    );
  }
}
