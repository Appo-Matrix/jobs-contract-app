// providers/invitation_provider.dart

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../data/models/invitation/delete_invitation_response.dart';
import '../../../../data/models/invitation/invitation_detail_model.dart';
import '../../../../data/models/invitation/invitation_model.dart';
import '../../../../data/models/invitation/send_invitation_request.dart';
import '../../../../data/models/invitation/send_invitation_response.dart';
import '../../../../data/models/invitation/user_invitation_model.dart';
import '../../../../data/repositories/invitation_repository_impl.dart';
import '../../../../domain/repository/invitation_repository.dart';


class InvitationProvider with ChangeNotifier {
  final InvitationRepository repository = InvitationRepositoryImpl();

  InvitationModel? _invitation;
  InvitationModel? get invitation => _invitation;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  SendInvitationResponse? _invitationResponse;
  SendInvitationResponse? get invitationResponse => _invitationResponse;


  DeleteInvitationResponse? _deleteResponse;
  DeleteInvitationResponse? get deleteResponse => _deleteResponse;

  InvitationDetailModel? _invitationDetailModel;
  InvitationDetailModel? get invitationDetailModel => _invitationDetailModel;


  List<InvitationDetailModel> _invitationsList = [];
  List<InvitationDetailModel> get invitationsList => _invitationsList;


  List<InvitationDetailModel> _jobInvitations = [];
  List<InvitationDetailModel> get jobInvitations => _jobInvitations;

  List<UserInvitationModel> _userInvitations = [];
  List<UserInvitationModel> get userInvitations => _userInvitations;


  InvitationModel? _rejectedInvitation;
  InvitationModel? get rejectedInvitation => _rejectedInvitation;

  Future<void> acceptInvitation(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _invitation = await repository.acceptInvitation(id);
      Fluttertoast.showToast(
        msg: "Invitation accepted successfully",
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

  Future<void> sendInvitation(SendInvitationRequest request) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _invitationResponse = await repository.sendInvitation(request);
      Fluttertoast.showToast(
        msg: _invitationResponse!.message,
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


  Future<void> deleteInvitation(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _deleteResponse = await repository.deleteInvitation(id);

      Fluttertoast.showToast(
        msg: _deleteResponse!.message,
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

  Future<void> fetchInvitationById(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _invitationDetailModel = await repository.getInvitationById(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllInvitations() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _invitationsList = await repository.getAllInvitations();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchInvitationsByJob(String jobId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _jobInvitations = await repository.getInvitationsByJob(jobId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserInvitations() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _userInvitations = await repository.getUserInvitations();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> rejectInvitation(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _rejectedInvitation = await repository.rejectInvitation(id);
      Fluttertoast.showToast(msg: "Invitation rejected successfully");
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(msg: _error ?? "Failed to reject invitation");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
