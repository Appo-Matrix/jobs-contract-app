// data/remote_data_sources/ticket_remote_data_source.dart



import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/support_tickets/create_ticket_request.dart';
import '../../models/support_tickets/create_ticket_response.dart';
import '../../models/support_tickets/resolve_ticket_request.dart';
import '../../models/support_tickets/resolve_ticket_response.dart';
import '../../models/support_tickets/ticket_detail_model.dart';
import '../../models/support_tickets/ticket_model.dart';
import '../../models/support_tickets/update_ticket_request.dart';
import '../../models/support_tickets/update_ticket_response.dart';
import '../../models/support_tickets/user_ticket_model.dart';

class TicketRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);


  Future<CreateTicketResponse> createTicket(CreateTicketRequest request) async {
    final response = await apiClient.post(
      endpoint: ApiPath.createSupportTicket,
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 201:
        return CreateTicketResponse.fromJson(response.data);
      case 400:
        throw Exception("Invalid input data");
      case 401:
        throw Exception("Unauthorized request");
      case 500:
        throw Exception("Server error: ${response.data['error']}");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<void> deleteTicket(String ticketId) async {
    final response = await apiClient.delete(
      endpoint: ApiPath.deleteTicket(ticketId),
    );

    switch (response.statusCode) {
      case 200:
      // Success, nothing returned
        return;
      case 401:
        throw Exception("Unauthorized request");
      case 404:
        throw Exception("Ticket not found");
      case 500:
        throw Exception("Server error: ${response.data['error']}");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<TicketDetailModel> getTicketById(String id) async {
    final response = await apiClient.get(
       ApiPath.getTicketById(id),
    );

    switch (response.statusCode) {
      case 200:
        return TicketDetailModel.fromJson(response.data);
      case 401:
        throw Exception("Unauthorized request");
      case 404:
        throw Exception("Ticket not found");
      case 500:
        throw Exception("Server error: ${response.data['error']}");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<UpdateTicketResponse> updateTicket(String id, UpdateTicketRequest request) async {
    final response = await apiClient.put(
      endpoint: ApiPath.updateTicket(id),
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return UpdateTicketResponse.fromJson(response.data);
      case 400:
        throw Exception("Invalid request data");
      case 401:
        throw Exception("Unauthorized request");
      case 404:
        throw Exception("Ticket not found");
      case 500:
        throw Exception("Server error: ${response.data['error']}");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<List<TicketModel>> getAllTickets() async {
    final response = await apiClient.get(ApiPath.getAllTickets);

    switch (response.statusCode) {
      case 200:
        return (response.data as List)
            .map((e) => TicketModel.fromJson(e))
            .toList();
      case 401:
        throw Exception("Unauthorized request");
      case 500:
        throw Exception("Server error: ${response.data['error']}");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<List<UserTicketModel>> getUserTickets() async {
    final response = await apiClient.get(ApiPath.getUserTickets);

    switch (response.statusCode) {
      case 200:
        return (response.data as List)
            .map((e) => UserTicketModel.fromJson(e))
            .toList();
      case 401:
        throw Exception("Unauthorized request");
      case 404:
        throw Exception("No tickets found");
      case 500:
        throw Exception("Server error: ${response.data['error']}");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<ResolveTicketResponse> resolveTicket(String id, ResolveTicketRequest request) async {
    final response = await apiClient.put(
      endpoint: ApiPath.resolveTicket(id),
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return ResolveTicketResponse.fromJson(response.data);
      case 400:
        throw Exception("Invalid request data");
      case 401:
        throw Exception("Unauthorized request");
      case 404:
        throw Exception("Ticket not found");
      case 500:
        throw Exception("Server error: ${response.data['error']}");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }
}
