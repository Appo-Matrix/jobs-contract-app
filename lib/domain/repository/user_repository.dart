
import '../../data/models/user/delete_resume_res.dart';
import '../../data/models/user/delete_user_res.dart';
import '../../data/models/user/update_user_profile_req.dart';
import '../../data/models/user/update_user_profile_res.dart';
import '../../data/models/user/user_talent_res.dart';

abstract class UserRepository {
  Future<DeleteResumeResponse> deleteResume();
  Future<DeleteUserResponse> deleteUser(String userId);
  Future<UpdateUserProfileResponse> updateUserProfile(String userId, UpdateUserProfileRequest request);
  Future<TalentListResponse> getTalents({int page, int limit});


}