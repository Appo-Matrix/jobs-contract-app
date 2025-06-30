// data/models/contracts/delete_contract_response.dart
class DeleteContractResponse {
  final bool success;
  final String message;

  DeleteContractResponse({
    required this.success,
    required this.message,
  });

  factory DeleteContractResponse.fromJson(Map<String, dynamic> json) {
    return DeleteContractResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
