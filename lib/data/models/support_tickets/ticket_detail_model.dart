// data/models/ticket/ticket_detail_model.dart

class TicketDetailModel {
  final String id;
  final String subject;
  final String description;
  final String issueType;
  final String priority;
  final String status;
  final String userName;
  final String userEmail;
  final String? assignedName;
  final String? assignedEmail;

  TicketDetailModel({
    required this.id,
    required this.subject,
    required this.description,
    required this.issueType,
    required this.priority,
    required this.status,
    required this.userName,
    required this.userEmail,
    this.assignedName,
    this.assignedEmail,
  });

  factory TicketDetailModel.fromJson(Map<String, dynamic> json) {
    return TicketDetailModel(
      id: json['_id'],
      subject: json['subject'],
      description: json['description'],
      issueType: json['issueType'],
      priority: json['priority'],
      status: json['status'],
      userName: json['user']['name'],
      userEmail: json['user']['email'],
      assignedName: json['assignedTo']?['name'],
      assignedEmail: json['assignedTo']?['email'],
    );
  }
}
