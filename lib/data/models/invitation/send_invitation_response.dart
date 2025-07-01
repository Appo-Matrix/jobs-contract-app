import 'invitation_model.dart';

class SendInvitationResponse {
  final String message;
  final InvitationModel invitation;

  SendInvitationResponse({
    required this.message,
    required this.invitation,
  });

  factory SendInvitationResponse.fromJson(Map<String, dynamic> json) {
    return SendInvitationResponse(
      message: json['message'],
      invitation: InvitationModel.fromJson(json['invitation']),
    );
  }
}
