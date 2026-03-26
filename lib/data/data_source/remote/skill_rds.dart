import 'package:flutter/cupertino.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/skills/add_skill_req.dart';
import '../../models/skills/add_skill_res.dart';
import '../../models/skills/skill_model.dart';

class SkillRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);

  // ── Add Skill ─────────────────────────────────────────────────────────────
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

  // ── Fetch All Skills (/skills/all) ────────────────────────────────────────
  // NOTE: This endpoint returns plain strings, not full objects.
  // SkillModel.id will be null for these items.
  Future<List<SkillModel>> fetchAllSkills() async {
    debugPrint('📡 fetchAllSkills → calling ${ApiPath.getAllSkills}');

    final response = await apiClient.get(ApiPath.getAllSkills);

    debugPrint('📡 fetchAllSkills → statusCode: ${response.statusCode}');

    switch (response.statusCode) {
      case 200:
        final raw = response.data;

        debugPrint('📡 fetchAllSkills → raw type: ${raw.runtimeType}');
        debugPrint('📡 fetchAllSkills → raw keys: ${raw is Map ? raw.keys.toList() : 'not a map'}');

        if (raw is! Map || !raw.containsKey('data')) {
          debugPrint('🔴 fetchAllSkills → unexpected format: $raw');
          throw Exception('Unexpected response format');
        }

        final data = raw['data'] as List;

        debugPrint('📡 fetchAllSkills → data length: ${data.length}');

        if (data.isEmpty) {
          debugPrint('⚠️ fetchAllSkills → data is empty');
          return [];
        }

        debugPrint('📡 fetchAllSkills → first item type: ${data.first.runtimeType}');
        debugPrint('📡 fetchAllSkills → first item value: ${data.first}');

        List<SkillModel> result;

        // API returns strings e.g. ["Flutter", "Dart", ...]
        if (data.first is String) {
          debugPrint('📡 fetchAllSkills → parsing as String list');
          result = data.map((e) => SkillModel(name: e.toString())).toList();
        } else {
          // Fallback: API returns full objects
          debugPrint('📡 fetchAllSkills → parsing as Map list');
          result = data
              .map((e) => SkillModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }

        debugPrint('✅ fetchAllSkills → parsed ${result.length} skills');
        debugPrint('✅ fetchAllSkills → sample: ${result.take(3).map((s) => s.name).toList()}');

        return result;

      case 404:
        debugPrint('⚠️ fetchAllSkills → 404 no skills found');
        return [];

      case 500:
        debugPrint('🔴 fetchAllSkills → 500 server error');
        throw Exception(response.data['error'] ?? 'Server Error');

      default:
        debugPrint('🔴 fetchAllSkills → unexpected status: ${response.statusCode}');
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }  // ── Fetch My Skills (/skills/me) ──────────────────────────────────────────
  // Returns full objects with _id, userId, name
  Future<List<SkillModel>> fetchMySkills() async {
    final response = await apiClient.get(ApiPath.getMySkills);

    switch (response.statusCode) {
      case 200:
        final List data = response.data['data'] as List;
        return data
            .map((e) => SkillModel.fromJson(e as Map<String, dynamic>))
            .toList();

      case 404:
        return [];

      case 401:
        throw Exception('Unauthorized');

      case 500:
        throw Exception(response.data['error'] ?? 'Server Error');

      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  // ── Fetch Skills By User ──────────────────────────────────────────────────
  Future<List<SkillModel>> fetchSkillsByUser(String userId) async {
    final response = await apiClient.get(ApiPath.getSkillsByUser(userId));

    switch (response.statusCode) {
      case 200:
        final data = response.data['data'] as List;
        return data
            .map((e) => SkillModel.fromJson(e as Map<String, dynamic>))
            .toList();

      case 404:
        return [];

      case 500:
        throw Exception(response.data['error'] ?? 'Server Error');

      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  // ── Delete Skill (by ID) ──────────────────────────────────────────────────
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
}