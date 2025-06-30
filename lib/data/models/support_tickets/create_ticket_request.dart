// models/tickets/create_ticket_request.dart

class CreateTicketRequest {
  final String subject;
  final String description;
  final String issueType;
  final String priority;

  CreateTicketRequest({
    required this.subject,
    required this.description,
    required this.issueType,
    required this.priority,
  });

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'description': description,
      'issueType': issueType,
      'priority': priority,
    };
  }
}
