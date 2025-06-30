// data/models/certificates/update_certificate_request.dart
class UpdateCertificateRequest {
  final String certificateName;
  final String issuedBy;
  final String year;

  UpdateCertificateRequest({
    required this.certificateName,
    required this.issuedBy,
    required this.year,
  });

  Map<String, dynamic> toJson() => {
    "certificateName": certificateName,
    "issuedBy": issuedBy,
    "year": year,
  };
}
