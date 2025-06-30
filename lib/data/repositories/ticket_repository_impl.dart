// data/repositories/ticket_repository_impl.dart

import '../../domain/repository/ticket_repository.dart';
import '../data_source/remote/ticket_rds.dart';
import '../models/support_tickets/create_ticket_request.dart';
import '../models/support_tickets/create_ticket_response.dart';
import '../models/support_tickets/resolve_ticket_request.dart';
import '../models/support_tickets/resolve_ticket_response.dart';
import '../models/support_tickets/ticket_detail_model.dart';
import '../models/support_tickets/ticket_model.dart';
import '../models/support_tickets/update_ticket_request.dart';
import '../models/support_tickets/update_ticket_response.dart';
import '../models/support_tickets/user_ticket_model.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketRemoteDataSource remoteDataSource = TicketRemoteDataSource();

  @override
  Future<CreateTicketResponse> createTicket(CreateTicketRequest request) async {
    try {
      return await remoteDataSource.createTicket(request);
    } catch (error) {
      throw Exception('Error in repository while creating ticket: $error');
    }
  }


  @override
  Future<void> deleteTicket(String ticketId) async {
    try {
      return await remoteDataSource.deleteTicket(ticketId);
    } catch (error) {
      throw Exception('Error in repository while deleting ticket: $error');
    }
  }

  @override
  Future<TicketDetailModel> getTicketById(String ticketId) async {
    try {
      return await remoteDataSource.getTicketById(ticketId);
    } catch (error) {
      throw Exception('Error fetching ticket: $error');
    }
  }

  @override
  Future<UpdateTicketResponse> updateTicket(String id, UpdateTicketRequest request) async {
    try {
      return await remoteDataSource.updateTicket(id, request);
    } catch (error) {
      throw Exception('Error updating ticket: $error');
    }
  }


  @override
  Future<List<TicketModel>> getAllTickets() async {
    try {
      return await remoteDataSource.getAllTickets();
    } catch (e) {
      throw Exception("Error in repository fetching tickets: $e");
    }
  }

  @override
  Future<List<UserTicketModel>> getUserTickets() async {
    try {
      return await remoteDataSource.getUserTickets();
    } catch (e) {
      throw Exception("Error in repository fetching user tickets: $e");
    }
  }

  @override
  Future<ResolveTicketResponse> resolveTicket(String id, ResolveTicketRequest request) async {
    try {
      return await remoteDataSource.resolveTicket(id, request);
    } catch (e) {
      throw Exception("Error in repository while resolving ticket: $e");
    }
  }
}
