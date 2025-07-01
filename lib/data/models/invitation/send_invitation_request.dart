class SendInvitationRequest {
  final String sender;
  final List<String> receivers;
  final String jobId;
  final String message;

  SendInvitationRequest({
    required this.sender,
    required this.receivers,
    required this.jobId,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'receivers': receivers,
      'jobId': jobId,
      'message': message,
    };
  }
}
