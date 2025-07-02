class PaymentMethodResponseModel {
  final String message;

  PaymentMethodResponseModel({required this.message});

  factory PaymentMethodResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodResponseModel(
      message: json['message'] ?? '',
    );
  }
}
