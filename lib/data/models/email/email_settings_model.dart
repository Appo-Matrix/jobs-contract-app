// lib/data/models/email/email_settings_model.dart

class EmailSettingsModel {
  final String? userId;
  final List<String> contractEmails;
  final String jobEmail;
  final String newMessages;

  EmailSettingsModel({
    this.userId,
    required this.contractEmails,
    required this.jobEmail,
    required this.newMessages,
  });

  factory EmailSettingsModel.fromJson(Map<String, dynamic> json) {
    return EmailSettingsModel(
      userId: json['userId'],
      contractEmails: List<String>.from(json['contractEmails'] ?? []),
      jobEmail: json['jobEmail'],
      newMessages: json['newMessages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contractEmails': contractEmails,
      'jobEmail': jobEmail,
      'newMessages': newMessages,
    };
  }
}
