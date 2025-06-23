

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


}
