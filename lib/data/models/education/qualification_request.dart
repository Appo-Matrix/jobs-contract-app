// qualification_request.dart
class QualificationRequest {
  final String degree;
  final String institutionName;
  final String startDate;
  final String endDate;
  final bool isCurrentPosition;

  QualificationRequest({
    required this.degree,
    required this.institutionName,
    required this.startDate,
    required this.endDate,
    this.isCurrentPosition = false,
  });

  Map<String, dynamic> toJson() => {
    'degree':            degree,
    'institutionName':   institutionName,
    'startDate':         startDate,
    'endDate':           endDate,
    'isCurrentPosition': isCurrentPosition,
  };
}