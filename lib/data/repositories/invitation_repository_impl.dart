// data/repositories/invitation_repository_impl.dart

import '../../domain/repository/invitation_repository.dart';
import '../data_source/remote/invitation_rds.dart';
import '../models/invitation/delete_invitation_response.dart';
import '../models/invitation/invitation_detail_model.dart';
import '../models/invitation/invitation_model.dart';
import '../models/invitation/send_invitation_request.dart';
import '../models/invitation/send_invitation_response.dart';
import '../models/invitation/user_invitation_model.dart';

class InvitationRepositoryImpl implements InvitationRepository {
  final InvitationRemoteDataSource remoteDataSource = InvitationRemoteDataSource();

  @override
  Future<InvitationModel> acceptInvitation(String id) async {
    try {
      return await remoteDataSource.acceptInvitation(id);
    } catch (e) {
      throw Exception('Error accepting invitation: $e');
    }
  }

  @override
  Future<SendInvitationResponse> sendInvitation(SendInvitationRequest request) async {
    try {
      return await remoteDataSource.sendInvitation(request);
    } catch (e) {
      throw Exception('Failed to send invitation: $e');
    }
  }

  @override
  Future<DeleteInvitationResponse> deleteInvitation(String id) async {
    try {
      return await remoteDataSource.deleteInvitation(id);
    } catch (e) {
      throw Exception('Failed to delete invitation: $e');
    }
  }


  @override
  Future<InvitationDetailModel> getInvitationById(String id) async {
    try {
      return await remoteDataSource.getInvitationById(id);
    } catch (e) {
      throw Exception('Error fetching invitation: $e');
    }
  }

  @override
  Future<List<InvitationDetailModel>> getAllInvitations() async {
    try {
      return await remoteDataSource.getAllInvitations();
    } catch (e) {
      throw Exception('Error fetching invitations: $e');
    }
  }

  @override
  Future<List<InvitationDetailModel>> getInvitationsByJob(String jobId) async {
    try {
      return await remoteDataSource.getInvitationsByJob(jobId);
    } catch (e) {
      throw Exception('Error getting job invitations: $e');
    }
  }

  @override
  Future<List<UserInvitationModel>> getUserInvitations() async {
    try {
      return await remoteDataSource.getUserInvitations();
    } catch (e) {
      throw Exception('Error getting user invitations: $e');
    }
  }

  @override
  Future<InvitationModel> rejectInvitation(String id) async {
    try {
      return await remoteDataSource.rejectInvitation(id);
    } catch (e) {
      throw Exception('Error rejecting invitation: $e');
    }
  }
}
