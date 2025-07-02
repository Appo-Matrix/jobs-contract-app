import 'package:job_contracts/core/constants/api_endpoints.dart';
import 'package:job_contracts/core/network/api_client.dart';

import '../../models/skills/add_skill_req.dart';
import '../../models/skills/add_skill_res.dart';
import '../../models/skills/skill_model.dart';

class SkillRemoteDataSource {

  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);

  Future<AddSkillResponse> addSkill(AddSkillRequest request) async {
    final response = await apiClient.post(
      endpoint: ApiPath.addSkill,
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 201:
        return AddSkillResponse.fromJson(response.data);
      case 400:
        throw Exception(response.data['message'] ?? 'Validation error');
      case 500:
        throw Exception(response.data['error'] ?? 'Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<List<SkillModel>> fetchAllSkills() async {
    final response = await apiClient.get(ApiPath.getAllSkills);

    switch (response.statusCode) {
      case 200:
        final data = response.data['data'] as List;
        return data.map((item) => SkillModel.fromJson(item)).toList();
      case 404:
        throw Exception(response.data['message'] ?? 'No skills found');
      case 500:
        throw Exception(response.data['error'] ?? 'Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<List<SkillModel>> fetchSkillsByUser(String userId) async {
    final response = await apiClient.get(
      ApiPath.getSkillsByUser(userId),
    );

    switch (response.statusCode) {
      case 200:
        final data = response.data['data'] as List;
        return data.map((e) => SkillModel.fromJson(e)).toList();
      case 404:
        throw Exception(response.data['message'] ?? 'No skills found for this user');
      case 500:
        throw Exception(response.data['error'] ?? 'Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<String> deleteSkill(String skillId) async {
    final response = await apiClient.delete(
      endpoint: ApiPath.deleteSkill(skillId),
    );

    switch (response.statusCode) {
      case 200:
        return response.data['message'] ?? 'Skill deleted successfully';
      case 404:
        throw Exception(response.data['message'] ?? 'Skill not found');
      case 500:
        throw Exception(response.data['error'] ?? 'Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<String> removeSkill(String skillId) async {
    final res = await apiClient.delete(endpoint: ApiPath.deleteSkillById(skillId));

    switch (res.statusCode) {
      case 200:
        return res.data['message'] ?? 'Skill removed successfully.';
      case 404:
        throw Exception(res.data['message'] ?? 'Skill not found');
      case 500:
        throw Exception(res.data['error'] ?? 'Something went wrong on the server');
      default:
        throw Exception('Unexpected status: ${res.statusCode}');
    }
  }
}
