class EducationModel {
  final String id;
  final String institutionName;  // ✅ was 'institution'
  final String degree;
  final String startDate;
  final String endDate;
  final bool isCurrentPosition;  // ✅ was missing

  EducationModel({
    required this.id,
    required this.institutionName,
    required this.degree,
    required this.startDate,
    required this.endDate,
    this.isCurrentPosition = false,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id:                json['_id']?.toString()             ?? '',
      institutionName:   json['institutionName']?.toString() ?? '', // ✅ fixed key
      degree:            json['degree']?.toString()          ?? '',
      startDate:         json['startDate']?.toString()       ?? '',
      endDate:           json['endDate']?.toString()         ?? '',
      isCurrentPosition: json['isCurrentPosition']           ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'institutionName':   institutionName,  // ✅ fixed key
      'degree':            degree,
      'startDate':         startDate,
      'endDate':           endDate,
      'isCurrentPosition': isCurrentPosition,
    };
  }
}