import '../../data/models/experience/experience_req.dart';
import '../../data/models/experience/experience_res.dart';
import '../../data/models/experience/work_experience.dart';

abstract class ExperienceRepository {

  Future<ExperienceResponse> addExperience(ExperienceRequest request);

  Future<List<WorkExperience>> getUserExperiences();

  Future<WorkExperience> getExperienceById(String id);

  Future<String> deleteExperienceById(String id);

  Future<Map<String, dynamic>> updateExperience(String id, Map<String, dynamic> updatedData);



}
