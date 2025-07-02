class CreatePaymentIntentResponseModel {
  final String clientSecret;

  CreatePaymentIntentResponseModel({required this.clientSecret});

  factory CreatePaymentIntentResponseModel.fromJson(Map<String, dynamic> json) {
    return CreatePaymentIntentResponseModel(
      clientSecret: json['clientSecret'] ?? '',
    );
  }
}
