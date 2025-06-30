// data/models/ticket/user_ticket_model.dart

class UserTicketModel {
  final String id;
  final String subject;
  final String description;
  final String issueType;
  final String priority;
  final String status;
  final DateTime createdAt;

  UserTicketModel({
    required this.id,
    required this.subject,
    required this.description,
    required this.issueType,
    required this.priority,
    required this.status,
    required this.createdAt,
  });

  factory UserTicketModel.fromJson(Map<String, dynamic> json) {
    return UserTicketModel(
      id: json['_id'],
      subject: json['subject'],
      description: json['description'],
      issueType: json['issueType'],
      priority: json['priority'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
