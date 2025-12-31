import '../../domain/repository/job_repository.dart';
import '../data_source/remote/job_rds.dart';
import '../models/jobs/create_job_request.dart';
import '../models/jobs/job_detail_model.dart';
import '../models/jobs/job_list_item_model.dart';
import '../models/jobs/job_metrics_model.dart';
import '../models/jobs/job_model.dart';
import '../models/jobs/job_report_model.dart';
import '../models/jobs/job_search_result_model.dart';
import '../models/jobs/matched_job_model.dart';
import '../models/jobs/pagination_job_model.dart' hide PaginatedJobsModel;
import '../models/jobs/recent_job_model.dart';
import '../models/saved_jobs/saved_jobs_model.dart';
import '../models/saved_jobs/toggle_saved_jobs_req.dart';
import '../models/saved_jobs/toggle_saved_jobs_res.dart';

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

  @override
  Future<List<JobListItemModel>> getMyPostedJobs() async {
    try {
      return await remoteDataSource.getMyPostedJobs();
    } catch (e) {
      throw Exception('Failed to load posted jobs: $e');
    }
  }

  @override
  Future<List<MatchedJobModel>> getMatchedJobs() async {
    try {
      return await remoteDataSource.getMatchedJobs();
    } catch (e) {
      throw Exception("Error fetching matched jobs: $e");
    }
  }

  @override
  Future<List<SavedJobModel>> fetchSavedJobs() async {
    try {
      return await remoteDataSource.getSavedJobs();
    } catch (e) {
      throw Exception('Failed to fetch saved jobs: $e');
    }
  }

  @override
  Future<List<RecentJobModel>> getRecentJobs({int page = 1, int limit = 10}) async {
    try {
      return await remoteDataSource.getRecentJobs(page: page, limit: limit);
    } catch (e) {
      throw Exception("Error fetching recent jobs: $e");
    }
  }

  @override
  Future<List<JobSearchResultModel>> searchJobs(Map<String, String> filters) async {
    try {
      return await remoteDataSource.searchJobs(filters);
    } catch (e) {
      throw Exception("Error searching jobs: $e");
    }
  }

  @override
  Future<JobReportModel> reportJob(JobReportModel report) async {
    try {
      return await remoteDataSource.reportJob(report);
    } catch (e) {
      throw Exception('Error reporting job: $e');
    }
  }

  @override
  Future<ToggleSaveJobResponse> toggleJobSaveStatus(ToggleSaveJobRequest request) async {
    try {
      return await remoteDataSource.toggleSaveJob(request);
    } catch (e) {
      throw Exception('Failed to toggle save status: $e');
    }
  }
}
