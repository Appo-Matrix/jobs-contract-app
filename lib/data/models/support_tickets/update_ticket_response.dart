// data/models/ticket/update_ticket_response.dart

class UpdateTicketResponse {
  final String message;
  final String id;
  final String status;
  final String assignedTo;

  UpdateTicketResponse({
    required this.message,
    required this.id,
    required this.status,
    required this.assignedTo,
  });

  factory UpdateTicketResponse.fromJson(Map<String, dynamic> json) {
    return UpdateTicketResponse(
      message: json['message'],
      id: json['ticket']['_id'],
      status: json['ticket']['status'],
      assignedTo: json['ticket']['assignedTo'],
    );
  }
}
