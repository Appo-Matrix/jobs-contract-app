import '../../data/models/reported_jobs/reported_jobs_model.dart';

abstract class ReportsRepository {

  Future<List<ReportedJobModel>> getAllReportedJobs();

  Future<ReportedJobModel> getReportById(String id);

  Future<List<ReportedJobModel>> getReportsByUser(String userId);

  Future<List<ReportedJobModel>> getReportsByJob(String jobId);


}
