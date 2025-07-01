// data/models/contracts/create_contract_request.dart
class CreateContractRequest {
  final String jobId;
  final String clientId;
  final String professionalId;
  final String startDate;
  final String endDate;
  final String terms;
  final PaymentDetails paymentDetails;

  CreateContractRequest({
    required this.jobId,
    required this.clientId,
    required this.professionalId,
    required this.startDate,
    required this.endDate,
    required this.terms,
    required this.paymentDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      "jobId": jobId,
      "clientId": clientId,
      "professionalId": professionalId,
      "startDate": startDate,
      "endDate": endDate,
      "terms": terms,
      "paymentDetails": paymentDetails.toJson(),
    };
  }
}

class PaymentDetails {
  final int amount;
  final String currency;

  PaymentDetails({
    required this.amount,
    required this.currency,
  });

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "currency": currency,
    };
  }
}
