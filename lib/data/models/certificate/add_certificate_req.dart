// add_certificate_request.dart
class AddCertificateRequest {
  final String certificateName;
  final String issuedBy;
  final String year;

  AddCertificateRequest({
    required this.certificateName,
    required this.issuedBy,
    required this.year,
  });

  Map<String, dynamic> toJson() {
    return {
      'certificateName': certificateName,
      'issuedBy': issuedBy,
      'year': year,
    };
  }
}
