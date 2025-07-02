import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/jobs/create_job_request.dart';
import '../../models/jobs/job_detail_model.dart';
import '../../models/jobs/job_list_item_model.dart';
import '../../models/jobs/job_metrics_model.dart';
import '../../models/jobs/job_model.dart';
import '../../models/jobs/job_report_model.dart';
import '../../models/jobs/job_search_result_model.dart';
import '../../models/jobs/matched_job_model.dart';
import '../../models/jobs/pagination_job_model.dart';
import '../../models/jobs/recent_job_model.dart';
import '../../models/saved_jobs/saved_jobs_model.dart';
import '../../models/saved_jobs/toggle_saved_jobs_req.dart';
import '../../models/saved_jobs/toggle_saved_jobs_res.dart';

class JobRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);


  Future<JobModel> createJob(CreateJobRequest request) async {
    final response = await apiClient.post(
      endpoint: ApiPath.createJob,
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 201:
        return JobModel.fromJson(response.data["job"]);
      case 400:
        throw Exception(response.data["message"] ?? "Validation error");
      case 401:
        throw Exception("Unauthorized user");
      case 500:
        throw Exception(response.data["error"] ?? "Server error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<JobMetricsModel> fetchJobMetrics() async {
    final response = await apiClient.get(ApiPath.adminMetrics);

    switch (response.statusCode) {
      case 200:
        return JobMetricsModel.fromJson(response.data);
      case 401:
        throw Exception("Unauthorized request");
      case 500:
        throw Exception("Server error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<String> deleteJob(String jobId) async {
    final response = await apiClient.delete(endpoint: ApiPath.deleteJob(jobId));

    switch (response.statusCode) {
      case 200:
        return response.data['message'];
      case 404:
        throw Exception(response.data['message'] ?? "Job not found");
      case 500:
        throw Exception(response.data['error'] ?? "Server error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<JobDetailModel> getJobById(String jobId) async {
    final response = await apiClient.get(ApiPath.getJobById(jobId));

    switch (response.statusCode) {
      case 200:
        return JobDetailModel.fromJson(response.data['job']);
      case 404:
        throw Exception(response.data['message'] ?? "Job not found");
      case 500:
        throw Exception(response.data['error'] ?? "Server error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<JobDetailModel> updateJob(String id, JobDetailModel data) async {
    final response = await apiClient.put(
      endpoint: ApiPath.updateJob(id),
      data: data.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return JobDetailModel.fromJson(response.data['job']);
      case 400:
        throw Exception("Invalid job data");
      case 404:
        throw Exception("Job not found");
      case 500:
        throw Exception(response.data['error'] ?? "Server error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<PaginatedJobsModel> getAllJobs({
    int page = 1,
    int limit = 10,
    String sortBy = 'date',
    String sortOrder = 'desc',
  }) async {
    final response = await apiClient.get(
       ApiPath.getAllJobs(
        page: page,
        limit: limit,
        sortBy: sortBy,
        sortOrder: sortOrder,
      ),
    );

    switch (response.statusCode) {
      case 200:
        return PaginatedJobsModel.fromJson(response.data);
      case 400:
        throw Exception(response.data['message'] ?? "Invalid pagination parameters.");
      case 500:
        throw Exception(response.data['error'] ?? "Internal server error.");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<List<JobListItemModel>> getMyPostedJobs() async {
    final response = await apiClient.get(ApiPath.jobsByUser);

    switch (response.statusCode) {
      case 200:
        return List<JobListItemModel>.from(
          response.data['jobs'].map((x) => JobListItemModel.fromJson(x)),
        );
      case 401:
        throw Exception(response.data['message'] ?? "Unauthorized request.");
      case 500:
        throw Exception(response.data['error'] ?? "Internal Server Error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<List<MatchedJobModel>> getMatchedJobs() async {
    final response = await apiClient.get( ApiPath.matchingJobs);

    switch (response.statusCode) {
      case 200:
        return List<MatchedJobModel>.from(
          response.data['data'].map((x) => MatchedJobModel.fromJson(x)),
        );
      case 401:
        throw Exception(response.data['message'] ?? "Unauthorized");
      case 404:
        throw Exception(response.data['message'] ?? "User not found");
      case 500:
        throw Exception(response.data['message'] ?? "Server Error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<List<RecentJobModel>> getRecentJobs({int page = 1, int limit = 10}) async {
    final response = await apiClient.get(
       ApiPath.getRecentJobs(page: page, limit: limit),
    );

    switch (response.statusCode) {
      case 200:
        return List<RecentJobModel>.from(
          response.data['data'].map((x) => RecentJobModel.fromJson(x)),
        );
      case 500:
        throw Exception(response.data['error'] ?? "Internal Server Error");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  @override
  Future<List<JobSearchResultModel>> searchJobs(Map<String, String> filters) async {
    final response = await apiClient.get(ApiPath.searchJobs,queryParameters:filters);

    if (response.statusCode == 200 && response.data['success'] == true) {
      final List jobs = response.data['data'];
      return jobs.map((e) => JobSearchResultModel.fromJson(e)).toList();
    } else {
      throw Exception(response.data['message'] ?? "Failed to search jobs");
    }
  }

  @override
  Future<JobReportModel> reportJob(JobReportModel report) async {
    final response = await apiClient.post(
      endpoint: ApiPath.reportJob,
      data: report.toJson(),
    );

    switch (response.statusCode) {
      case 201:
        return JobReportModel.fromJson(response.data['data']);
      case 400:
      case 404:
        throw Exception(response.data['message']);
      case 500:
        throw Exception(response.data['error'] ?? 'Internal server error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<List<SavedJobModel>> getSavedJobs() async {
    final response = await apiClient.get(ApiPath.getSavedJobs);

    switch (response.statusCode) {
      case 200:
        final List data = response.data['data'];
        return data.map((e) => SavedJobModel.fromJson(e)).toList();
      case 401:
        throw Exception(response.data['message'] ?? 'Unauthorized');
      case 500:
        throw Exception(response.data['error'] ?? 'Internal Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<ToggleSaveJobResponse> toggleSaveJob(ToggleSaveJobRequest request) async {
    final response = await apiClient.post(
      endpoint: ApiPath.toggleSaveJob,
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 200:
      case 201:
        return ToggleSaveJobResponse.fromJson(response.data);
      case 400:
        throw Exception(response.data['message'] ?? 'Validation Error');
      case 500:
        throw Exception(response.data['error'] ?? 'Internal Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }
}
