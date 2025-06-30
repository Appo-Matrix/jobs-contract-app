
class UpdateTicketRequest {
  final String status;
  final String assignedTo;

  UpdateTicketRequest({
    required this.status,
    required this.assignedTo,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'assignedTo': assignedTo,
    };
  }
}
