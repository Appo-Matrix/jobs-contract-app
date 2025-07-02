class BankAccountResponseModel {
  final String id;
  final String object;
  final String country;
  final String currency;
  final String last4;
  final String status;

  BankAccountResponseModel({
    required this.id,
    required this.object,
    required this.country,
    required this.currency,
    required this.last4,
    required this.status,
  });

  factory BankAccountResponseModel.fromJson(Map<String, dynamic> json) {
    return BankAccountResponseModel(
      id: json['id'] ?? '',
      object: json['object'] ?? '',
      country: json['country'] ?? '',
      currency: json['currency'] ?? '',
      last4: json['last4'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
