
import '../../data/models/user/contractor_by_speciality_res.dart';
import '../../data/models/user/delete_resume_res.dart';
import '../../data/models/user/delete_user_res.dart';
import '../../data/models/user/update_user_profile_req.dart';
import '../../data/models/user/update_user_profile_res.dart';
import '../../data/models/user/user_hired_talent_res.dart';
import '../../data/models/user/user_talent_res.dart';

abstract class UserRepository {
  Future<DeleteResumeResponse> deleteResume();
  Future<DeleteUserResponse> deleteUser(String userId);
  Future<UpdateUserProfileResponse> updateUserProfile(String userId, UpdateUserProfileRequest request);
  Future<TalentListResponse> getTalents({int page, int limit});
  Future<HiredTalentListResponse> getHiredTalents({int page, int limit});
  Future<ContractorBySpecialityResponse> getContractorsBySpeciality({required String speciality, int page, int limit,});



}