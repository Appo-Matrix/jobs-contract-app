import 'package:job_contracts/core/constants/api_endpoints.dart';
import 'package:job_contracts/core/network/api_client.dart';

import '../../models/saved_talents/saved_talent_res.dart';
import '../../models/saved_talents/toggle_talent_save_req.dart';
import '../../models/saved_talents/toggle_talent_save_res.dart';

class TalentRemoteDataSource {

  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);


  Future<SavedTalentsResponse> fetchSavedTalents() async {
    final response = await apiClient.get(ApiPath.getSavedTalents);

    switch (response.statusCode) {
      case 200:
        return SavedTalentsResponse.fromJson(response.data);
      case 404:
        throw Exception(response.data['message'] ?? 'No saved talents found');
      case 500:
        throw Exception(response.data['error'] ?? 'Internal Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<ToggleTalentSaveResponse> toggleSaveTalent(ToggleTalentSaveRequest request) async {
    final response = await apiClient.post(
      endpoint: ApiPath.toggleSaveTalent,
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 200:
      case 201:
        return ToggleTalentSaveResponse.fromJson(response.data);
      case 400:
        throw Exception(response.data['message'] ?? 'Validation error');
      case 500:
        throw Exception(response.data['error'] ?? 'Server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }
}
