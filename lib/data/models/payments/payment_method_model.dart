class CardDetails {
  final String brand;
  final String last4;
  final int expMonth;
  final int expYear;

  CardDetails({
    required this.brand,
    required this.last4,
    required this.expMonth,
    required this.expYear,
  });

  factory CardDetails.fromJson(Map<String, dynamic> json) {
    return CardDetails(
      brand: json['brand'] ?? '',
      last4: json['last4'] ?? '',
      expMonth: json['exp_month'] ?? 0,
      expYear: json['exp_year'] ?? 0,
    );
  }
}

class PaymentMethodModel {
  final String id;
  final String type;
  final CardDetails? card;

  PaymentMethodModel({
    required this.id,
    required this.type,
    this.card,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      card: json['card'] != null ? CardDetails.fromJson(json['card']) : null,
    );
  }
}
