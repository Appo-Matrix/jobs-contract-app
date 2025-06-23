

import 'package:job_contracts/data/models/user/delete_user_res.dart';

import '../../domain/repository/user_repository.dart';
import '../data_source/remote/user_rds.dart';
import '../models/user/delete_resume_res.dart';

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


}
