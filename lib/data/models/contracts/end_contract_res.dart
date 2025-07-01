// models/contracts/end_contract_response.dart
class EndContractResponse {
  final bool success;
  final String message;
  final ContractStatusData data;

  EndContractResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory EndContractResponse.fromJson(Map<String, dynamic> json) {
    return EndContractResponse(
      success: json['success'],
      message: json['message'],
      data: ContractStatusData.fromJson(json['data']),
    );
  }
}

class ContractStatusData {
  final String id;
  final String status;

  ContractStatusData({
    required this.id,
    required this.status,
  });

  factory ContractStatusData.fromJson(Map<String, dynamic> json) {
    return ContractStatusData(
      id: json['_id'],
      status: json['status'],
    );
  }
}
