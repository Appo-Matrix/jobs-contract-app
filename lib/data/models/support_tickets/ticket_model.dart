// data/models/ticket/ticket_model.dart

class TicketModel {
  final String id;
  final String subject;
  final String description;
  final String issueType;
  final String priority;
  final String status;
  final UserInfo user;
  final UserInfo assignedTo;

  TicketModel({
    required this.id,
    required this.subject,
    required this.description,
    required this.issueType,
    required this.priority,
    required this.status,
    required this.user,
    required this.assignedTo,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['_id'],
      subject: json['subject'],
      description: json['description'],
      issueType: json['issueType'],
      priority: json['priority'],
      status: json['status'],
      user: UserInfo.fromJson(json['user']),
      assignedTo: UserInfo.fromJson(json['assignedTo']),
    );
  }
}

class UserInfo {
  final String name;
  final String email;

  UserInfo({required this.name, required this.email});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      name: json['name'],
      email: json['email'],
    );
  }
}
