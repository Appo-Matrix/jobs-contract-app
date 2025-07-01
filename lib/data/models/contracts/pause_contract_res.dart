// models/contracts/pause_contract_response.dart

class PauseContractResponse {
  final bool success;
  final String message;
  final ContractData data;

  PauseContractResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PauseContractResponse.fromJson(Map<String, dynamic> json) {
    return PauseContractResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
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
      id: json['_id'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
