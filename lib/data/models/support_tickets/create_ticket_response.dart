// models/tickets/create_ticket_response.dart

class CreateTicketResponse {
  final String message;
  final String newTicket;

  CreateTicketResponse({
    required this.message,
    required this.newTicket,
  });

  factory CreateTicketResponse.fromJson(Map<String, dynamic> json) {
    return CreateTicketResponse(
      message: json['message'] ?? '',
      newTicket: json['newTicket'] ?? '',
    );
  }
}
