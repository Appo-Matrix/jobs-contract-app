class QualificationResponse {
  final String message;
  final Map<String, dynamic> education;

  QualificationResponse({required this.message, required this.education});

  factory QualificationResponse.fromJson(Map<String, dynamic> json) {
    return QualificationResponse(
      message: json['message'],
      education: json['education'],
    );
  }
}
