import 'package:job_contracts/data/data_source/remote/experience_rds.dart';

import '../../domain/repository/experience_repository.dart';
import '../models/experience/experience_req.dart';
import '../models/experience/experience_res.dart';
import '../models/experience/work_experience.dart';

class ExperienceRepositoryImpl implements ExperienceRepository {
  final ExperienceRemoteDataSource rds = ExperienceRemoteDataSource();


  @override
  Future<ExperienceResponse> addExperience(ExperienceRequest request) async {
    try {
      return await rds.addExperience(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<WorkExperience>> getUserExperiences() async {
    try {
      return await rds.fetchUserExperiences();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WorkExperience> getExperienceById(String id) async {
    try {
      return await rds.fetchExperienceById(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> deleteExperienceById(String id) async {
    try {
      return await rds.deleteExperience(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> updateExperience(String id, Map<String, dynamic> updatedData) async {
    try {
      return await rds.updateExperience(id: id, data: updatedData);
    } catch (e) {
      rethrow;
    }
  }
}
