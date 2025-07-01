// models/contracts/get_contract_by_id_response.dart
class GetContractByIdResponse {
  final bool success;
  final String message;
  final ContractData data;

  GetContractByIdResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetContractByIdResponse.fromJson(Map<String, dynamic> json) {
    return GetContractByIdResponse(
      success: json['success'],
      message: json['message'],
      data: ContractData.fromJson(json['data']),
    );
  }
}

class ContractData {
  final String id;
  final String job;
  final String clientId;
  final String professionalId;
  final String startDate;
  final String endDate;
  final String terms;
  final PaymentDetails paymentDetails;
  final String status;

  ContractData({
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

  factory ContractData.fromJson(Map<String, dynamic> json) {
    return ContractData(
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
