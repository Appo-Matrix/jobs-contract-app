

import 'package:job_contracts/data/models/user/delete_user_res.dart';

import '../../domain/repository/user_repository.dart';
import '../data_source/remote/user_rds.dart';
import '../models/user/contractor_by_speciality_res.dart';
import '../models/user/current_user_res.dart';
import '../models/user/delete_resume_res.dart';
import '../models/user/featured_company_res.dart';
import '../models/user/top_performer_res.dart';
import '../models/user/update_current_user_profile_req.dart';
import '../models/user/update_user_profile_req.dart';
import '../models/user/update_user_profile_res.dart';
import '../models/user/upload_resume_req.dart';
import '../models/user/upload_resume_res.dart';
import '../models/user/user_hired_talent_res.dart';
import '../models/user/user_talent_res.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource= UserRemoteDataSource();


  @override
  Future<DeleteResumeResponse> deleteResume() async{
    try {
      return await remoteDataSource.deleteResume();
    } catch (error) {
      throw Exception('Error in repository during resume deletion: $error');
    }
  }

  @override
  Future<DeleteUserResponse> deleteUser(String userId) async {
    try {
      return await remoteDataSource.deleteUser(userId);
    }catch(e){
      throw Exception('Error in repository during user deletion: $e');

    }
  }

  @override
  Future<UpdateUserProfileResponse> updateUserProfile(String userId, UpdateUserProfileRequest request,) async {
    try {
      return await remoteDataSource.updateUserProfile(userId, request);
    } catch(e){
      throw Exception('Error in repository during profile updation: $e');

    }
  }

  @override
  Future<TalentListResponse> getTalents({int page = 1, int limit = 10}) async {
    try {
      return await remoteDataSource.getTalents(page: page, limit: limit);
    } catch (e) {
      throw Exception("Repository error while fetching talents: $e");
    }
  }

  @override
  Future<HiredTalentListResponse> getHiredTalents({int page = 1, int limit = 10}) async {
    try {
      return await remoteDataSource.getHiredTalents(page: page, limit: limit);
    } catch (e) {
      throw Exception("Repository error while fetching hired talents: $e");
    }
  }

  @override
  Future<ContractorBySpecialityResponse> getContractorsBySpeciality({
    required String speciality,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      return await remoteDataSource.getContractorsBySpeciality(
        speciality: speciality,
        page: page,
        limit: limit,
      );
    } catch (e) {
      throw Exception('Error in repository while fetching contractors: $e');
    }
  }

  @override
  Future<FeaturedCompanyResponse> getFeaturedCompanies({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      return await remoteDataSource.getFeaturedCompanies(
        page: page,
        limit: limit,
      );
    } catch (e) {
      throw Exception('Error fetching featured companies: $e');
    }
  }

  @override
  Future<List<TopPerformer>> getTopPerformers({
    String timePeriod = 'all',
    int page = 1,
    int limit = 10,
  }) async {
    try {
      return await remoteDataSource.getTopPerformers(
        timePeriod: timePeriod,
        page: page,
        limit: limit,
      );
    } catch (e) {
      throw Exception('Error fetching top performers: $e');
    }
  }

  @override
  Future<CurrentUser> getCurrentUser() async {
    try {
      return await remoteDataSource.getCurrentUser();
    } catch (e) {
      throw Exception('Error fetching current user: $e');
    }
  }
  @override
  Future<CurrentUser> updateCurrentUserProfile(UpdateCurrentUserProfileRequest request) async {
    try {
      return await remoteDataSource.updateCurrentUserProfile(request);
    } catch (e) {
      throw Exception('Error updating current user profile: $e');
    }
  }

  @override
  Future<UploadResumeResponse> uploadResume(UploadResumeRequest request) async {
    try {
      return await remoteDataSource.uploadResume(request);
    } catch (e) {
      throw Exception('Error uploading resume :$e');
    }
  }



}
