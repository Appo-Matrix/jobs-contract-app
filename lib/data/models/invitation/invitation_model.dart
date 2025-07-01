// data/models/invitation/invitation_model.dart

class InvitationModel {
  final String id;
  final String jobId;
  final String sender;
  final List<ReceiverStatus> receivers;
  final String message;
  final String expiresAt;
  final String createdAt;
  final String updatedAt;

  InvitationModel({
    required this.id,
    required this.jobId,
    required this.sender,
    required this.receivers,
    required this.message,
    required this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      id: json['_id'],
      jobId: json['jobId'],
      sender: json['sender'],
      receivers: (json['receivers'] as List)
          .map((r) => ReceiverStatus.fromJson(r))
          .toList(),
      message: json['message'],
      expiresAt: json['expiresAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class ReceiverStatus {
  final String userId;
  final String status;

  ReceiverStatus({
    required this.userId,
    required this.status,
  });

  factory ReceiverStatus.fromJson(Map<String, dynamic> json) {
    return ReceiverStatus(
      userId: json['userId'],
      status: json['status'],
    );
  }
}
