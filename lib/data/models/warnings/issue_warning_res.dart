class IssueWarningResponse {
  final String message;
  final Warning warning;

  IssueWarningResponse({
    required this.message,
    required this.warning,
  });

  factory IssueWarningResponse.fromJson(Map<String, dynamic> json) {
    return IssueWarningResponse(
      message: json['message'],
      warning: Warning.fromJson(json['warning']),
    );
  }
}

class Warning {
  final String id;
  final String userId;
  final String reason;
  final DateTime createdAt;

  Warning({
    required this.id,
    required this.userId,
    required this.reason,
    required this.createdAt,
  });

  factory Warning.fromJson(Map<String, dynamic> json) {
    return Warning(
      id: json['_id'],
      userId: json['userId'],
      reason: json['reason'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
