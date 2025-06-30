// providers/ticket_provider.dart

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../data/models/support_tickets/create_ticket_request.dart';
import '../../../../data/models/support_tickets/create_ticket_response.dart';
import '../../../../data/models/support_tickets/resolve_ticket_request.dart';
import '../../../../data/models/support_tickets/resolve_ticket_response.dart';
import '../../../../data/models/support_tickets/ticket_detail_model.dart';
import '../../../../data/models/support_tickets/ticket_model.dart';
import '../../../../data/models/support_tickets/update_ticket_request.dart';
import '../../../../data/models/support_tickets/update_ticket_response.dart';
import '../../../../data/models/support_tickets/user_ticket_model.dart';
import '../../../../data/repositories/ticket_repository_impl.dart';
import '../../../../domain/repository/ticket_repository.dart';


class TicketProvider with ChangeNotifier {
  final TicketRepository repository = TicketRepositoryImpl();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  CreateTicketResponse? _response;
  CreateTicketResponse? get response => _response;

  UpdateTicketResponse? _updateResponse;
  UpdateTicketResponse? get updateResponse => _updateResponse;

  List<TicketModel> _tickets = [];
  List<TicketModel> get tickets => _tickets;

  TicketDetailModel? _ticketDetail;
  TicketDetailModel? get ticketDetail => _ticketDetail;

  Future<void> createTicket(CreateTicketRequest request) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _response = await repository.createTicket(request);

      Fluttertoast.showToast(
        msg: _response?.message ?? "Ticket created",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(
        msg: _error!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteTicket(BuildContext context, String ticketId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await repository.deleteTicket(ticketId);

      Fluttertoast.showToast(
        msg: "Ticket deleted successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(
        msg: _error!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchTicketById(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _ticketDetail = await repository.getTicketById(id);
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(
        msg: _error!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTicket(String ticketId, UpdateTicketRequest request) async {
    _isLoading = true;
    notifyListeners();

    try {
      _updateResponse = await repository.updateTicket(ticketId, request);
      Fluttertoast.showToast(
        msg: _updateResponse!.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(
        msg: _error!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> fetchAllTickets() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tickets = await repository.getAllTickets();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



  List<UserTicketModel> _userTickets = [];
  List<UserTicketModel> get userTickets => _userTickets;


  Future<void> fetchUserTickets() async {
    _isLoading = true;
    notifyListeners();

    try {
      _userTickets = await repository.getUserTickets();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  bool _isResolving = false;
  bool get isResolving => _isResolving;

  String? _resolveError;
  String? get resolveError => _resolveError;

  ResolveTicketResponse? _resolveResponse;
  ResolveTicketResponse? get resolveResponse => _resolveResponse;

  Future<void> resolveTicket(String id, ResolveTicketRequest request) async {
    _isResolving = true;
    _resolveError = null;
    notifyListeners();

    try {
      _resolveResponse = await repository.resolveTicket(id, request);
    } catch (e) {
      _resolveError = e.toString();
    } finally {
      _isResolving = false;
      notifyListeners();
    }
  }
}
