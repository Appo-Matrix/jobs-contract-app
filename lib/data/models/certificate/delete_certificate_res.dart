// delete_certificate_response.dart
class DeleteCertificateResponse {
  final String message;

  DeleteCertificateResponse({required this.message});

  factory DeleteCertificateResponse.fromJson(Map<String, dynamic> json) {
    return DeleteCertificateResponse(
      message: json['message'] ?? 'Unknown response',
    );
  }
}
