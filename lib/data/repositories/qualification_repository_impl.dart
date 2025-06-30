
import 'package:job_contracts/data/data_source/remote/qualifications_rds.dart';

import '../../domain/repository/qualification_repository.dart';
import '../models/education/education_model.dart';
import '../models/education/qualification_model.dart';
import '../models/education/qualification_request.dart';
import '../models/education/qualification_response.dart';
import '../models/education/user_education_model.dart';

class QualificationRepositoryImpl implements QualificationRepository {

  final QualificationRemoteDataSource remoteDataSource= QualificationRemoteDataSource();


  @override
  Future<QualificationResponse> addQualification(QualificationRequest request) async {
    try {
      return await remoteDataSource.addQualification(request);
    } catch (error) {
      throw Exception('Error adding qualification: $error');
    }
  }

  @override
  Future<void> deleteQualification(String eduId) async {
    try {
      return await remoteDataSource.deleteQualification(eduId);
    } catch (error) {
      throw Exception('Error deleting qualification: $error');
    }
  }

  @override
  Future<EducationModel> getQualificationById(String eduId) async {
    try {
      return await remoteDataSource.getQualificationById(eduId);
    } catch (error) {
      throw Exception('Error fetching qualification by ID: $error');
    }
  }

  @override
  Future<EducationModel> updateQualification(String eduId, EducationModel data) async {
    try {
      return await remoteDataSource.updateQualification(eduId, data);
    } catch (error) {
      throw Exception('Error updating qualification: $error');
    }
  }


  @override
  Future<List<QualificationModel>> getQualificationsByUserId(String userId) async {
    try {
      return await remoteDataSource.getQualificationsByUserId(userId);
    } catch (error) {
      throw Exception('Error fetching qualifications: $error');
    }
  }

  @override
  Future<List<UserEducationModel>> getMyQualifications() async {
    try {
      return await remoteDataSource.getMyQualifications();
    } catch (e) {
      throw Exception('Error fetching education entries: $e');
    }
  }
}