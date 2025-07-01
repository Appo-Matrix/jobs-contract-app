// data/models/ticket/resolve_ticket_request.dart

class ResolveTicketRequest {
  final String resolutionMessage;

  ResolveTicketRequest({required this.resolutionMessage});

  Map<String, dynamic> toJson() {
    return {
      "resolutionMessage": resolutionMessage,
    };
  }
}
