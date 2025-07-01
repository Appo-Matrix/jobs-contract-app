
import 'package:job_contracts/core/constants/api_endpoints.dart';

import '../../../core/network/api_client.dart';
import '../../models/preferences/delete_preferences_response_model.dart';
import '../../models/preferences/real_estate_preferences_model.dart';
import '../../models/preferences/user_preference_user_model.dart';
import '../../models/preferences/user_preferences_model.dart';

class PreferencesRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);

  Future<DeletePreferencesResponseModel> deleteUserPreferences(String userId) async {
    final response = await apiClient.delete(
      endpoint: ApiPath.deleteJobPreferences(userId),
    );

    if (response.statusCode == 200) {
      return DeletePreferencesResponseModel.fromJson(response.data);
    } else if (response.statusCode == 404) {
      throw Exception('Preferences not found');
    } else {
      throw Exception(response.data['error'] ?? 'Unexpected server error');
    }
  }

  Future<UserPreferencesModel> getUserPreferences(String userId) async {
    final response = await apiClient.get(
       ApiPath.getUserPreferences(userId),
    );

    if (response.statusCode == 200) {
      return UserPreferencesModel.fromJson(response.data['data']);
    } else if (response.statusCode == 404) {
      throw Exception('Preferences not found');
    } else {
      throw Exception(response.data['error'] ?? 'Unexpected server error');
    }
  }

  Future<List<PreferenceUserModel>> searchUsersByJobPreference(String job) async {
    final response = await apiClient.get(
       ApiPath.searchUsersByJobPreference(job),
    );

    if (response.statusCode == 200) {
      return List<PreferenceUserModel>.from(
        (response.data['data'] as List).map((e) => PreferenceUserModel.fromJson(e)),
      );
    } else if (response.statusCode == 400) {
      throw Exception('Invalid job input');
    } else {
      throw Exception(response.data['error'] ?? 'Server error');
    }
  }

  Future<RealEstatePreferencesModel> updatePreferences(RealEstatePreferencesModel model) async {
    final response = await apiClient.post(
      endpoint: ApiPath.updateRealEstatePreferences,
      data: model.toJson(),
    );

    if (response.statusCode == 200) {
      return RealEstatePreferencesModel.fromJson(response.data['data']);
    } else if (response.statusCode == 400) {
      throw Exception("Invalid input");
    } else {
      throw Exception(response.data['error'] ?? "Server error");
    }
  }
}
