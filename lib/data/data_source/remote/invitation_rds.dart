// data/data_source/remote/invitation_rds.dart

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/invitation/delete_invitation_response.dart';
import '../../models/invitation/invitation_detail_model.dart';
import '../../models/invitation/invitation_model.dart';
import '../../models/invitation/send_invitation_request.dart';
import '../../models/invitation/send_invitation_response.dart';
import '../../models/invitation/user_invitation_model.dart';

class InvitationRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);

  Future<InvitationModel> acceptInvitation(String id) async {
    final response = await apiClient.put(endpoint: ApiPath.acceptInvitation(id));

    if (response.statusCode == 200) {
      return InvitationModel.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message'] ?? 'Failed to accept invitation');
    }
  }

  Future<SendInvitationResponse> sendInvitation(SendInvitationRequest request) async {
    final response = await apiClient.post(
      endpoint: ApiPath.sendInvitation,
      data: request.toJson(),
    );

    if (response.statusCode == 201) {
      return SendInvitationResponse.fromJson(response.data);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw Exception(response.data['message'] ?? 'Request error');
    } else {
      throw Exception(response.data['message'] ?? 'Server error');
    }
  }

  Future<DeleteInvitationResponse> deleteInvitation(String id) async {
    final response = await apiClient.delete(
      endpoint: ApiPath.deleteInvitation(id),
    );

    if (response.statusCode == 200) {
      return DeleteInvitationResponse.fromJson(response.data);
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      throw Exception(response.data['message']);
    } else {
      throw Exception(response.data['error'] ?? 'Unexpected error');
    }
  }

  Future<InvitationDetailModel> getInvitationById(String id) async {
    final response = await apiClient.get('${ApiPath.getInvitationById}/$id');

    if (response.statusCode == 200) {
      return InvitationDetailModel.fromJson(response.data);
    } else {
      throw Exception(response.data['message'] ?? 'Failed to fetch invitation');
    }
  }

  Future<List<InvitationDetailModel>> getAllInvitations() async {
    final response = await apiClient.get(ApiPath.getAllInvitations);

    if (response.statusCode == 200) {
      return List<InvitationDetailModel>.from(
        response.data.map((item) => InvitationDetailModel.fromJson(item)),
      );
    } else {
      throw Exception(response.data['message'] ?? 'Failed to fetch invitations');
    }
  }

  Future<List<InvitationDetailModel>> getInvitationsByJob(String jobId) async {
    final response = await apiClient.get(ApiPath.getInvitationsByJob(jobId));

    if (response.statusCode == 200) {
      final List invitations = response.data['invitations'];
      return invitations.map((e) => InvitationDetailModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      throw Exception(response.data['message']);
    } else {
      throw Exception(response.data['message'] ?? 'Failed to fetch invitations for job');
    }
  }


  Future<List<UserInvitationModel>> getUserInvitations() async {
    final response = await apiClient.get(ApiPath.userInvitations);

    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((e) => UserInvitationModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      throw Exception(response.data['message']);
    } else {
      throw Exception(response.data['error'] ?? 'Failed to fetch user invitations');
    }
  }


  Future<InvitationModel> rejectInvitation(String id) async {
    final response = await apiClient.put(endpoint: ApiPath.rejectInvitation(id));

    if (response.statusCode == 200) {
      return InvitationModel.fromJson(response.data['data']);
    } else if (response.statusCode == 400 || response.statusCode == 401 || response.statusCode == 404) {
      throw Exception(response.data['message']);
    } else {
      throw Exception(response.data['error'] ?? 'Failed to reject invitation');
    }
  }
}
