

import 'package:job_contracts/core/constants/api_endpoints.dart';

import '../../../core/network/api_client.dart';
import '../../models/job_applications/job_application_model.dart';
import '../../models/job_applications/job_application_response.dart';
import '../../models/job_applications/job_application_response_model.dart';
import '../../models/job_applications/job_application_submit_request.dart';
import '../../models/job_applications/update_application_request.dart';

class ApplicationRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);

  Future<JobApplicationModel> getApplicationById(String id) async {
    final response = await apiClient.get(ApiPath.getJobApplicationById(id));

    if (response.statusCode == 200) {
      return JobApplicationModel.fromJson(response.data['data']);
    } else if (response.statusCode == 404) {
      throw Exception(response.data['message'] ?? 'Job application not found');
    } else {
      throw Exception(response.data['error'] ?? 'Server error');
    }
  }

  Future<void> deleteApplication(String id) async {
    final response = await apiClient.delete(endpoint: ApiPath.deleteJobApplication(id));

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 404 || response.statusCode == 401) {
      throw Exception(response.data['message']);
    } else {
      throw Exception(response.data['error'] ?? 'Unexpected error occurred');
    }
  }

  Future<JobApplicationModel> updateApplication(String id, UpdateApplicationRequest request) async {
    final response = await apiClient.put(
      endpoint: ApiPath.updateJobApplication(id),
      data: request.toJson(),
    );

    if (response.statusCode == 200) {
      return JobApplicationModel.fromJson(response.data['data']);
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      throw Exception(response.data['message'] ?? response.data['errors']?.join(", "));
    } else {
      throw Exception(response.data['error'] ?? 'Unexpected error');
    }
  }

  Future<JobApplicationResponse> getApplicationsByJobId(String jobId) async {
    final response = await apiClient.get(
      '${ApiPath.getApplicationsByJobId}/$jobId',
    );

    if (response.statusCode == 200) {
      return JobApplicationResponse.fromJson(response.data);
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      throw Exception(response.data['message']);
    } else {
      throw Exception(response.data['error'] ?? 'Unexpected error');
    }
  }

  Future<JobApplicationResponse> getMyJobApplications() async {
    final response = await apiClient.get(ApiPath.myJobApplications);

    if (response.statusCode == 200) {
      return JobApplicationResponse.fromJson(response.data);
    } else if (response.statusCode == 401) {
      throw Exception(response.data['message']);
    } else {
      throw Exception(response.data['error'] ?? 'Unexpected error');
    }
  }

  Future<JobApplicationResponseModel> submitJobApplication(JobApplicationSubmitRequest request) async {
    final response = await apiClient.post(
      endpoint: ApiPath.submitJobApplication,
      data: request.toJson(),
    );

    if (response.statusCode == 201) {
      return JobApplicationResponseModel.fromJson(response.data);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw Exception(response.data['message'] ?? response.data['errors']?.join(', '));
    } else {
      throw Exception(response.data['error'] ?? 'Unexpected error occurred');
    }
  }
}
