import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/user/delete_resume_res.dart';

class UserRemoteDataSource {

  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);



  Future<DeleteResumeResponse> deleteResume() async {
    try {
      final response = await apiClient.delete(
        endpoint: ApiPath.deleteResume,
      );

      if (response.statusCode == 200) {
        return DeleteResumeResponse.fromJson(response.data);
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        throw Exception(response.data['message']);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception(response.data['message'] ?? 'Server error');
      } else {
        throw Exception("Failed with status code: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error deleting resume: $error");
    }
  }
}
