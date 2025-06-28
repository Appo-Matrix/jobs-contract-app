import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/user/contractor_by_speciality_res.dart';
import '../../models/user/current_user_res.dart';
import '../../models/user/delete_resume_res.dart';
import '../../models/user/delete_user_res.dart';
import '../../models/user/featured_company_res.dart';
import '../../models/user/top_performer_res.dart';
import '../../models/user/update_current_user_profile_req.dart';
import '../../models/user/update_user_profile_req.dart';
import '../../models/user/update_user_profile_res.dart';
import '../../models/user/user_hired_talent_res.dart';
import '../../models/user/user_talent_res.dart';

class UserRemoteDataSource {

  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);


  Future<DeleteResumeResponse> deleteResume() async {
    try {
      final response = await apiClient.delete(
        endpoint: ApiPath.deleteResume,
      );

      if (response.statusCode == 200) {
        return DeleteResumeResponse.fromJson(response.data);
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        throw Exception(response.data['message']);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception(response.data['message'] ?? 'Server error');
      } else {
        throw Exception("Failed with status code: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error deleting resume: $error");
    }
  }

  // ⛔ DELETE User by ID
  Future<DeleteUserResponse> deleteUser(String userId) async {
    try {
      final response = await apiClient.delete(
        endpoint: '${ApiPath.deleteUser}/$userId',
      );

      if (response.statusCode == 200) {
        return DeleteUserResponse.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to delete user');
      }
    } catch (error) {
      throw Exception('Failed to delete user: $error');
    }
  }

  Future<UpdateUserProfileResponse> updateUserProfile(
      String userId,
      UpdateUserProfileRequest request,
      ) async {


    try {

      final response = await apiClient.put(endpoint: ApiPath.updateUserProfile(userId),
      data: request.toJson(),
      );


      if (response.statusCode == 200) {
        return UpdateUserProfileResponse.fromJson(response.data);
      } else if (response.statusCode == 400) {
        throw Exception("Invalid request data");
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 404) {
        throw Exception("User not found");
      } else {
        throw Exception("Unexpected error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error updating profile: $e");
    }
  }

  Future<TalentListResponse> getTalents({int page = 1, int limit = 10}) async {
    try {
      final response = await apiClient.get(
        ApiPath.getTalents,
        queryParameters: {
          "page": page,
          "limit": limit,
        },
      );

      if (response.statusCode == 200) {
        return TalentListResponse.fromJson(response.data);
      } else if (response.statusCode == 500) {
        throw Exception("Server error occurred");
      } else {
        throw Exception("Failed to load talents: ${response.statusMessage}");
      }
    } catch (error) {
      debugPrint('getTalents error: $error');
      throw Exception("Unexpected error: $error");
    }
  }

  Future<HiredTalentListResponse> getHiredTalents({int page = 1, int limit = 10}) async {
    try {
      final response = await apiClient.get(
        ApiPath.getHiredTalents,
        queryParameters: {
          "page": page,
          "limit": limit,
        },
      );

      if (response.statusCode == 200) {
        return HiredTalentListResponse.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized access");
      } else if (response.statusCode == 500) {
        throw Exception("Server error. Please try again later.");
      } else {
        throw Exception("Failed with status: ${response.statusMessage}");
      }
    } catch (error) {
      debugPrint("getHiredTalents error: $error");
      throw Exception("Unexpected error: $error");
    }
  }

  Future<ContractorBySpecialityResponse> getContractorsBySpeciality({
    required String speciality,
    int page = 1,
    int limit = 10,
  }) async {
    final response = await apiClient.get(
      ApiPath.contractorsBySpeciality(speciality),
      queryParameters: {
        'page': page,
        'limit': limit,
      },
    );

    if (response.statusCode == 200) {
      return ContractorBySpecialityResponse.fromJson(response.data);
    } else if (response.statusCode == 400) {
      throw Exception(response.data['message'] ?? 'Invalid speciality');
    } else if (response.statusCode == 500) {
      throw Exception(response.data['error'] ?? 'Server error');
    } else {
      throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<FeaturedCompanyResponse> getFeaturedCompanies({
    int page = 1,
    int limit = 10,
  }) async {
    final response = await apiClient.get(
      ApiPath.getFeaturedCompanies,
      queryParameters: {
        'page': page,
        'limit': limit,
      },
    );

    if (response.statusCode == 200) {
      return FeaturedCompanyResponse.fromJson(response.data);
    } else if (response.statusCode == 500) {
      throw Exception(response.data['error'] ?? 'Server error');
    } else {
      throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<List<TopPerformer>> getTopPerformers({
    String timePeriod = 'all',
    int page = 1,
    int limit = 10,
  }) async {
    final response = await apiClient.get(
      ApiPath.getTopPerformers,
      queryParameters: {
        'timePeriod': timePeriod,
        'page': page,
        'limit': limit,
      },
    );

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((json) => TopPerformer.fromJson(json))
          .toList();
    } else if (response.statusCode == 400) {
      throw Exception(response.data['message'] ?? 'Invalid query parameters');
    } else if (response.statusCode == 401) {
      throw Exception(response.data['message'] ?? 'Unauthorized');
    } else if (response.statusCode == 404) {
      throw Exception(response.data['message'] ?? 'No professionals found');
    } else if (response.statusCode == 500) {
      throw Exception(response.data['message'] ?? 'Server error');
    } else {
      throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<CurrentUser> getCurrentUser() async {
    final response = await apiClient.get(ApiPath.getCurrentUser);

    if (response.statusCode == 200) {
      return CurrentUser.fromJson(response.data);
    } else if (response.statusCode == 401) {
      throw Exception(response.data['error'] ?? 'Unauthorized');
    } else if (response.statusCode == 404) {
      throw Exception(response.data['error'] ?? 'User not found');
    } else if (response.statusCode == 500) {
      throw Exception(response.data['error'] ?? 'Internal server error');
    } else {
      throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<CurrentUser> updateCurrentUserProfile(UpdateCurrentUserProfileRequest request) async {
    final formData = await request.toFormData();

    final response = await apiClient.putMultipart(
      endpoint: ApiPath.updateCurrentUserProfile, // like "/users/me"
      data: formData,
    );

    if (response.statusCode == 200) {
      return CurrentUser.fromJson(response.data);
    } else if (response.statusCode == 400) {
      throw Exception("Invalid request data");
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else if (response.statusCode == 404) {
      throw Exception("User not found");
    } else if (response.statusCode == 500) {
      throw Exception("Internal server error");
    } else {
      throw Exception("Unexpected error: ${response.statusCode}");
    }
  }




}

