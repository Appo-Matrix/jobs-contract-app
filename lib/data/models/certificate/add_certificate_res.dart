// add_certificate_response.dart
class AddCertificateResponse {
  final String id;
  final String userId;
  final String certificateName;
  final String issuedBy;
  final String year;
  final String createdAt;
  final String updatedAt;

  AddCertificateResponse({
    required this.id,
    required this.userId,
    required this.certificateName,
    required this.issuedBy,
    required this.year,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddCertificateResponse.fromJson(Map<String, dynamic> json) {
    return AddCertificateResponse(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      certificateName: json['certificateName'] ?? '',
      issuedBy: json['issuedBy'] ?? '',
      year: json['year'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
