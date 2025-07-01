// data/models/invitations/user_invitation_model.dart

class UserInvitationModel {
  final String id;
  final Sender sender;
  final Job job;
  final String status;
  final String message;
  final DateTime expiresAt;

  UserInvitationModel({
    required this.id,
    required this.sender,
    required this.job,
    required this.status,
    required this.message,
    required this.expiresAt,
  });

  factory UserInvitationModel.fromJson(Map<String, dynamic> json) {
    return UserInvitationModel(
      id: json['_id'],
      sender: Sender.fromJson(json['sender']),
      job: Job.fromJson(json['jobId']),
      status: json['status'],
      message: json['message'],
      expiresAt: DateTime.parse(json['expiresAt']),
    );
  }
}

class Sender {
  final String id;
  final String name;
  final String email;

  Sender({required this.id, required this.name, required this.email});

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class Job {
  final String id;
  final String title;

  Job({required this.id, required this.title});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['_id'],
      title: json['title'],
    );
  }
}
