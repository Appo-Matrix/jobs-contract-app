// models/contracts/active_contract_model.dart

class ActiveContractModel {
  final String id;
  final String job;
  final String clientId;
  final String professionalId;
  final String startDate;
  final String endDate;
  final String terms;
  final PaymentDetails paymentDetails;
  final String status;

  ActiveContractModel({
    required this.id,
    required this.job,
    required this.clientId,
    required this.professionalId,
    required this.startDate,
    required this.endDate,
    required this.terms,
    required this.paymentDetails,
    required this.status,
  });

  factory ActiveContractModel.fromJson(Map<String, dynamic> json) {
    return ActiveContractModel(
      id: json['_id'],
      job: json['job'],
      clientId: json['clientId'],
      professionalId: json['professionalId'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      terms: json['terms'],
      paymentDetails: PaymentDetails.fromJson(json['paymentDetails']),
      status: json['status'],
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
