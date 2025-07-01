// domain/repository/invitation_repository.dart

import '../../data/models/invitation/delete_invitation_response.dart';
import '../../data/models/invitation/invitation_detail_model.dart';
import '../../data/models/invitation/invitation_model.dart';
import '../../data/models/invitation/send_invitation_request.dart';
import '../../data/models/invitation/send_invitation_response.dart';
import '../../data/models/invitation/user_invitation_model.dart';

abstract class InvitationRepository {

  Future<InvitationModel> acceptInvitation(String id);

  Future<SendInvitationResponse> sendInvitation(SendInvitationRequest request);

  Future<DeleteInvitationResponse> deleteInvitation(String id);

  Future<InvitationDetailModel> getInvitationById(String id);

  Future<List<InvitationDetailModel>> getAllInvitations();

  Future<List<InvitationDetailModel>> getInvitationsByJob(String jobId);

  Future<List<UserInvitationModel>> getUserInvitations();

  Future<InvitationModel> rejectInvitation(String id);



}
