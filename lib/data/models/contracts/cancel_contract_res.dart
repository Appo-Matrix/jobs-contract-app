class CancelContractResponse {
  final bool success;
  final String message;
  final String id;
  final String clientId;
  final String professionalId;
  final String status;

  CancelContractResponse({
    required this.success,
    required this.message,
    required this.id,
    required this.clientId,
    required this.professionalId,
    required this.status,
  });

  factory CancelContractResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return CancelContractResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      id: data['_id'] ?? '',
      clientId: data['clientId'] ?? '',
      professionalId: data['professionalId'] ?? '',
      status: data['status'] ?? '',
    );
  }
}
