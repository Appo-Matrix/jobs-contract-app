import '../../domain/repository/job_repository.dart';
import '../data_source/remote/job_rds.dart';
import '../models/jobs/create_job_request.dart';
import '../models/jobs/job_detail_model.dart';
import '../models/jobs/job_metrics_model.dart';
import '../models/jobs/job_model.dart';
import '../models/jobs/pagination_job_model.dart';

class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource remoteDataSource=JobRemoteDataSource();


  @override
  Future<JobModel> createJob(CreateJobRequest request) async {
    try {
      return await remoteDataSource.createJob(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<JobMetricsModel> fetchJobMetrics() async {
    try {
      return await remoteDataSource.fetchJobMetrics();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> deleteJob(String jobId) async {
    try {
      return await remoteDataSource.deleteJob(jobId);
    } catch (e) {
      throw Exception("Error deleting job: $e");
    }
  }

  @override
  Future<JobDetailModel> getJobById(String jobId) async {
    try {
      return await remoteDataSource.getJobById(jobId);
    } catch (e) {
      throw Exception("Error fetching job: $e");
    }
  }

  @override
  Future<JobDetailModel> updateJob(String id, JobDetailModel data) async {
    try {
      return await remoteDataSource.updateJob(id, data);
    } catch (error) {
      throw Exception("Error updating job: $error");
    }
  }

  @override
  Future<PaginatedJobsModel> getAllJobs({
    int page = 1,
    int limit = 10,
    String sortBy = 'date',
    String sortOrder = 'desc',
  }) async {
    try {
      return await remoteDataSource.getAllJobs(
        page: page,
        limit: limit,
        sortBy: sortBy,
        sortOrder: sortOrder,
      );
    } catch (e) {
      throw Exception("Failed to fetch jobs: $e");
    }
  }
}
