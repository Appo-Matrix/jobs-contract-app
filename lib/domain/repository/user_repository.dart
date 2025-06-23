
import '../../data/models/user/delete_resume_res.dart';
import '../../data/models/user/delete_user_res.dart';

abstract class UserRepository {
  Future<DeleteResumeResponse> deleteResume();
  Future<DeleteUserResponse> deleteUser(String userId);

}