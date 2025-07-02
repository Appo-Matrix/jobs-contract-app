class IssueWarningRequest {
  final String userId;
  final String reason;

  IssueWarningRequest({
    required this.userId,
    required this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'reason': reason,
    };
  }
}
