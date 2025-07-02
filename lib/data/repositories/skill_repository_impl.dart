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
      return await remoteDataSource.addSkill(request);
    } catch (e) {
      throw Exception('Failed to add skill: $e');
    }
  }

  @override
  Future<List<SkillModel>> fetchAllSkills() async {
    try {
      return await remoteDataSource.fetchAllSkills();
    } catch (e) {
      throw Exception('Failed to fetch skills: $e');
    }
  }

  @override
  Future<List<SkillModel>> fetchSkillsByUser(String userId) async {
    try {
      return await remoteDataSource.fetchSkillsByUser(userId);
    } catch (e) {
      throw Exception('Failed to fetch user skills: $e');
    }
  }


  @override
  Future<String> deleteSkill(String skillId) async {
    try {
      return await remoteDataSource.deleteSkill(skillId);
    } catch (e) {
      throw Exception('Failed to delete skill: $e');
    }
  }

  @override
  Future<String> removeSkillById(String id) async {
    try {
      return await remoteDataSource.removeSkill(id);
    }  catch (e) {
      throw Exception('Failed to remove skill: $e');

    }

  }
}
