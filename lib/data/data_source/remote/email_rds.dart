

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/email/email_settings_model.dart';

class EmailRemoteDataSource {

  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);


  Future<EmailSettingsModel> updateEmailSettings(EmailSettingsModel data) async {
    final response = await apiClient.post(
      endpoint: ApiPath.updateEmailSettings,
      data: data.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return EmailSettingsModel.fromJson(response.data['data']);
      case 400:
        throw Exception(response.data['message'] ?? "Invalid request data");
      case 500:
        throw Exception(response.data['error'] ?? "Server Error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }
}