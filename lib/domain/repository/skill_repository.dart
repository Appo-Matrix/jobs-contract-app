import '../../data/models/skills/add_skill_req.dart';
import '../../data/models/skills/add_skill_res.dart';
import '../../data/models/skills/skill_model.dart';

abstract class SkillRepository {

  Future<AddSkillResponse> addSkill(AddSkillRequest request);

  Future<List<SkillModel>> fetchAllSkills();

  Future<List<SkillModel>> fetchSkillsByUser(String userId);

  Future<String> deleteSkill(String skillId);

  Future<String> removeSkillById(String id);



}
