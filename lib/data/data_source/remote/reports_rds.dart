import 'package:job_contracts/core/constants/api_endpoints.dart';
import 'package:job_contracts/core/network/api_client.dart';

import '../../models/reported_jobs/reported_jobs_model.dart';

class ReportsRemoteDataSource {

  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);


  Future<List<ReportedJobModel>> getAllReportedJobs() async {
    final response = await apiClient.get(ApiPath.getAllReportedJobs);

    switch (response.statusCode) {
      case 200:
        final List<dynamic> data = response.data['data'];
        return data.map((e) => ReportedJobModel.fromJson(e)).toList();
      case 500:
        throw Exception(response.data['error'] ?? 'Internal Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<ReportedJobModel> fetchReportById(String id) async {
    final response = await apiClient.get(ApiPath.getReportedJobById(id));

    switch (response.statusCode) {
      case 200:
        return ReportedJobModel.fromJson(response.data['data']);
      case 404:
        throw Exception('Report not found');
      case 500:
        throw Exception(response.data['error'] ?? 'Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<List<ReportedJobModel>> fetchReportsByUser(String userId) async {
    final response = await apiClient.get(ApiPath.getUserReports(userId));

    switch (response.statusCode) {
      case 200:
        final List data = response.data['data'];
        return data.map((e) => ReportedJobModel.fromJson(e)).toList();
      case 404:
        throw Exception('No reports found for this user');
      case 500:
        throw Exception(response.data['error'] ?? 'Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<List<ReportedJobModel>> fetchReportsByJob(String jobId) async {
    final response = await apiClient.get(ApiPath.getReportsByJob(jobId));

    switch (response.statusCode) {
      case 200:
        final List data = response.data['data'];
        return data.map((e) => ReportedJobModel.fromJson(e)).toList();
      case 404:
        throw Exception('No reports found for this job');
      case 500:
        throw Exception(response.data['error'] ?? 'Internal Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }
}
