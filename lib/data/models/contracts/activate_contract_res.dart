// data/models/contract/activate_contract_response.dart

class ActivateContractResponse {
  final bool success;
  final String message;
  final ContractData data;

  ActivateContractResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ActivateContractResponse.fromJson(Map<String, dynamic> json) {
    return ActivateContractResponse(
      success: json['success'],
      message: json['message'],
      data: ContractData.fromJson(json['data']),
    );
  }
}

class ContractData {
  final String id;
  final String status;

  ContractData({required this.id, required this.status});

  factory ContractData.fromJson(Map<String, dynamic> json) {
    return ContractData(
      id: json['_id'],
      status: json['status'],
    );
  }
}
