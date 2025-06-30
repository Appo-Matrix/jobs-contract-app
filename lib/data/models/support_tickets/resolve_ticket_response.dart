// data/models/ticket/resolve_ticket_response.dart

class ResolveTicketResponse {
  final String message;
  final String id;
  final String status;
  final String resolutionMessage;
  final DateTime resolvedAt;

  ResolveTicketResponse({
    required this.message,
    required this.id,
    required this.status,
    required this.resolutionMessage,
    required this.resolvedAt,
  });

  factory ResolveTicketResponse.fromJson(Map<String, dynamic> json) {
    final ticket = json['ticket'];
    return ResolveTicketResponse(
      message: json['message'],
      id: ticket['_id'],
      status: ticket['status'],
      resolutionMessage: ticket['resolutionMessage'],
      resolvedAt: DateTime.parse(ticket['resolvedAt']),
    );
  }
}
