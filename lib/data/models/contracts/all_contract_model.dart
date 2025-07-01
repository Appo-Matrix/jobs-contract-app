// models/contracts/all_contract_model.dart

class AllContractModel {
  final String id;
  final String job;
  final String client;
  final String professional;
  final String startDate;
  final String endDate;
  final String terms;
  final PaymentDetails paymentDetails;
  final String signedDate;

  AllContractModel({
    required this.id,
    required this.job,
    required this.client,
    required this.professional,
    required this.startDate,
    required this.endDate,
    required this.terms,
    required this.paymentDetails,
    required this.signedDate,
  });

  factory AllContractModel.fromJson(Map<String, dynamic> json) {
    return AllContractModel(
      id: json['_id'],
      job: json['job'],
      client: json['client'],
      professional: json['professional'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      terms: json['terms'],
      paymentDetails: PaymentDetails.fromJson(json['paymentDetails']),
      signedDate: json['signedDate'],
    );
  }
}

class PaymentDetails {
  final int amount;
  final String currency;

  PaymentDetails({
    required this.amount,
    required this.currency,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      amount: json['amount'],
      currency: json['currency'],
    );
  }
}
