

import '../../data/models/support_tickets/create_ticket_request.dart';
import '../../data/models/support_tickets/create_ticket_response.dart';
import '../../data/models/support_tickets/resolve_ticket_request.dart';
import '../../data/models/support_tickets/resolve_ticket_response.dart';
import '../../data/models/support_tickets/ticket_detail_model.dart';
import '../../data/models/support_tickets/ticket_model.dart';
import '../../data/models/support_tickets/update_ticket_request.dart';
import '../../data/models/support_tickets/update_ticket_response.dart';
import '../../data/models/support_tickets/user_ticket_model.dart';

abstract class TicketRepository {

  Future<CreateTicketResponse> createTicket(CreateTicketRequest request);

  Future<void> deleteTicket(String ticketId);

  Future<TicketDetailModel> getTicketById(String ticketId);

  Future<UpdateTicketResponse> updateTicket(String id, UpdateTicketRequest request);

  Future<List<TicketModel>> getAllTickets();

  Future<List<UserTicketModel>> getUserTickets();

  Future<ResolveTicketResponse> resolveTicket(String id, ResolveTicketRequest request);




}