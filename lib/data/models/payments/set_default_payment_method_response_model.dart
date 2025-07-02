class SetDefaultPaymentMethodResponseModel {
  final String message;

  SetDefaultPaymentMethodResponseModel({required this.message});

  factory SetDefaultPaymentMethodResponseModel.fromJson(Map<String, dynamic> json) {
    return SetDefaultPaymentMethodResponseModel(
      message: json['message'] ?? '',
    );
  }
}
