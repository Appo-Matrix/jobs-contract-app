

import 'package:job_contracts/data/models/user/delete_user_res.dart';

import '../../domain/repository/user_repository.dart';
import '../data_source/remote/user_rds.dart';
import '../models/user/delete_resume_res.dart';
import '../models/user/update_user_profile_req.dart';
import '../models/user/update_user_profile_res.dart';
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


}
