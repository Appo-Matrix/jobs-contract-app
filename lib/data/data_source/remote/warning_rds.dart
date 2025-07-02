import 'package:job_contracts/core/constants/api_endpoints.dart';
import 'package:job_contracts/core/network/api_client.dart';

import '../../models/warnings/delete_warning_res.dart';
import '../../models/warnings/issue_warning_req.dart';
import '../../models/warnings/issue_warning_res.dart';
import '../../models/warnings/user_warning.dart';
import '../../models/warnings/warning_model.dart';

class WarningRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);


  Future<IssueWarningResponse> issueWarning(IssueWarningRequest request) async {
    final response = await apiClient.post(
      endpoint: ApiPath.issueWarning,
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 201:
        return IssueWarningResponse.fromJson(response.data);
      case 400:
        throw Exception(response.data['errors']?.join(", ") ?? 'Validation error');
      case 500:
        throw Exception('Internal Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }


  Future<DeleteWarningResponse> deleteWarning(String id) async {
    final response = await apiClient.delete(
      endpoint: ApiPath.deleteWarning(id),
    );

    switch (response.statusCode) {
      case 200:
        return DeleteWarningResponse.fromJson(response.data);
      case 404:
        throw Exception(response.data['message'] ?? 'Warning not found');
      case 500:
        throw Exception(response.data['error'] ?? 'Server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<List<WarningModel>> getMyWarnings() async {
    final response = await apiClient.get(ApiPath.getMyWarnings);

    switch (response.statusCode) {
      case 200:
        return (response.data as List)
            .map((json) => WarningModel.fromJson(json))
            .toList();
      case 401:
        throw Exception('Unauthorized request');
      case 404:
        throw Exception('No warnings found for this user');
      case 500:
        throw Exception(response.data['error'] ?? 'Server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<List<UserWarning>> getWarningsByUserId(String userId) async {
    final response = await apiClient.get(ApiPath.getUserWarnings(userId));

    switch (response.statusCode) {
      case 200:
        return (response.data as List)
            .map((json) => UserWarning.fromJson(json))
            .toList();
      case 404:
        throw Exception('No warnings found for this user');
      case 500:
        throw Exception(response.data['error'] ?? 'Server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }
}
