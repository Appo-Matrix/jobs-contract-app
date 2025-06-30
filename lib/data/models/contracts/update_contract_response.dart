// models/contracts/update_contract_response.dart

class UpdateContractResponse {
  final bool success;
  final String message;
  final String data;

  UpdateContractResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UpdateContractResponse.fromJson(Map<String, dynamic> json) {
    return UpdateContractResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? '',
    );
  }
}
