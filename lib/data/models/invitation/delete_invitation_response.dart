class DeleteInvitationResponse {
  final bool success;
  final String message;

  DeleteInvitationResponse({
    required this.success,
    required this.message,
  });

  factory DeleteInvitationResponse.fromJson(Map<String, dynamic> json) {
    return DeleteInvitationResponse(
      success: json['success'],
      message: json['message'],
    );
  }
}
