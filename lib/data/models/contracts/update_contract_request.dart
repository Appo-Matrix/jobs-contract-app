// models/contracts/update_contract_request.dart

class UpdateContractRequest {
  final String jobId;
  final String clientId;
  final String professionalId;
  final String startDate;
  final String endDate;
  final String terms;
  final PaymentDetails paymentDetails;
  final String status;

  UpdateContractRequest({
    required this.jobId,
    required this.clientId,
    required this.professionalId,
    required this.startDate,
    required this.endDate,
    required this.terms,
    required this.paymentDetails,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
    "jobId": jobId,
    "clientId": clientId,
    "professionalId": professionalId,
    "startDate": startDate,
    "endDate": endDate,
    "terms": terms,
    "paymentDetails": paymentDetails.toJson(),
    "status": status,
  };
}

class PaymentDetails {
  final int amount;
  final String currency;

  PaymentDetails({required this.amount, required this.currency});

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currency": currency,
  };
}
