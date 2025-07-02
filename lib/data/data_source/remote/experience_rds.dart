import 'package:job_contracts/core/constants/api_endpoints.dart';
import 'package:job_contracts/core/network/api_client.dart';

import '../../models/experience/experience_req.dart';
import '../../models/experience/experience_res.dart';
import '../../models/experience/work_experience.dart';

class ExperienceRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);


  Future<ExperienceResponse> addExperience(ExperienceRequest request) async {
    final response = await apiClient.post(
      endpoint: ApiPath.addExperience,
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 201:
        return ExperienceResponse.fromJson(response.data);
      case 400:
        throw Exception(response.data['error'] ?? 'Validation error');
      case 500:
        throw Exception('Server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }


  Future<List<WorkExperience>> fetchUserExperiences() async {
    final response = await apiClient.get(ApiPath.getUserExperiences);

    switch (response.statusCode) {
      case 200:
        List data = response.data['data'];
        return data.map((e) => WorkExperience.fromJson(e)).toList();
      case 404:
        throw Exception(response.data['message'] ?? 'No experiences found');
      case 500:
        throw Exception(response.data['error'] ?? 'Server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }


  Future<WorkExperience> fetchExperienceById(String id) async {
    final response = await apiClient.get(ApiPath.getExperienceById(id));

    switch (response.statusCode) {
      case 200:
        return WorkExperience.fromJson(response.data);
      case 404:
        throw Exception(response.data['error'] ?? 'Experience not found');
      case 500:
        throw Exception('Server error: ${response.data['error']}');
      default:
        throw Exception('Unexpected error occurred');
    }
  }


  Future<String> deleteExperience(String id) async {
    final response = await apiClient.delete(endpoint: ApiPath.deleteExperience(id));

    switch (response.statusCode) {
      case 200:
        return response.data['message'] ?? 'Work experience deleted successfully';
      case 404:
        throw Exception(response.data['error'] ?? 'Work experience not found');
      case 500:
        throw Exception('Server error: ${response.data['error']}');
      default:
        throw Exception('Unexpected error occurred');
    }
  }

  Future<Map<String, dynamic>> updateExperience({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    final response = await apiClient.put(
      endpoint: ApiPath.updateExperience(id),
      data: data,
    );

    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        throw Exception(response.data['error'] ?? 'Validation error');
      case 404:
        throw Exception('Work experience not found');
      case 500:
        throw Exception('Server error: ${response.data['error']}');
      default:
        throw Exception('Unexpected error occurred');
    }
  }
}
