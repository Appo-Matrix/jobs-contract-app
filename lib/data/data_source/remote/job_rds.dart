import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/jobs/create_job_request.dart';
import '../../models/jobs/job_detail_model.dart';
import '../../models/jobs/job_metrics_model.dart';
import '../../models/jobs/job_model.dart';
import '../../models/jobs/pagination_job_model.dart';

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
}
