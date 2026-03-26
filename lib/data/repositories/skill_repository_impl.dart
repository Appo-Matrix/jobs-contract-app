import 'package:flutter/foundation.dart';

import '../../domain/repository/skill_repository.dart';
import '../data_source/remote/skill_rds.dart';
import '../models/skills/add_skill_req.dart';
import '../models/skills/add_skill_res.dart';
import '../models/skills/skill_model.dart';

class SkillRepositoryImpl implements SkillRepository {
  final SkillRemoteDataSource remoteDataSource = SkillRemoteDataSource();

  @override
  Future<AddSkillResponse> addSkill(AddSkillRequest request) async {
    try {
      debugPrint('addSkill → request: $request');
      return await remoteDataSource.addSkill(request);
    } catch (e, st) {
      debugPrint('addSkill error: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<List<SkillModel>> fetchAllSkills() async {
    try {
      debugPrint('fetchAllSkills → start');
      return await remoteDataSource.fetchAllSkills();
    } catch (e, st) {
      debugPrint('fetchAllSkills error: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<List<SkillModel>> fetchMySkills() async {
    try {
      debugPrint('fetchMySkills → start');
      return await remoteDataSource.fetchMySkills();
    } catch (e, st) {
      debugPrint('fetchMySkills error: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<List<SkillModel>> fetchSkillsByUser(String userId) async {
    try {
      debugPrint('fetchSkillsByUser → userId: $userId');
      return await remoteDataSource.fetchSkillsByUser(userId);
    } catch (e, st) {
      debugPrint('fetchSkillsByUser error: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<String> deleteSkill(String skillId) async {
    try {
      debugPrint('deleteSkill → skillId: $skillId');
      return await remoteDataSource.deleteSkill(skillId);
    } catch (e, st) {
      debugPrint('deleteSkill error: $e\n$st');
      rethrow;
    }
  }
}