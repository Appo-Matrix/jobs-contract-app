// data/models/contracts/create_contract_response.dart
class CreateContractResponse {
  final bool success;
  final String message;
  final String data;

  CreateContractResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CreateContractResponse.fromJson(Map<String, dynamic> json) {
    return CreateContractResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? '',
    );
  }
}
