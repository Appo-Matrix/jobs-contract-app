
import '../../data/models/user/delete_resume_res.dart';

abstract class UserRepository {
  Future<DeleteResumeResponse> deleteResume();
}