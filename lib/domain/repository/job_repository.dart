import '../../data/models/jobs/create_job_request.dart';
import '../../data/models/jobs/job_detail_model.dart';
import '../../data/models/jobs/job_metrics_model.dart';
import '../../data/models/jobs/job_model.dart';
import '../../data/models/jobs/pagination_job_model.dart';

abstract class JobRepository {

  Future<JobModel> createJob(CreateJobRequest request);

  Future<JobMetricsModel> fetchJobMetrics();

  Future<String> deleteJob(String jobId);

  Future<JobDetailModel> getJobById(String jobId);

  Future<JobDetailModel> updateJob(String id, JobDetailModel data);

  Future<PaginatedJobsModel> getAllJobs({int page, int limit, String sortBy, String sortOrder,});






}
