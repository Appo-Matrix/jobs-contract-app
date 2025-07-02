import '../../domain/repository/reports_repository.dart';
import '../data_source/remote/reports_rds.dart';
import '../models/reported_jobs/reported_jobs_model.dart';

class ReportsRepositoryImpl implements ReportsRepository {

  final ReportsRemoteDataSource remoteDataSource= ReportsRemoteDataSource();

  @override
  Future<List<ReportedJobModel>> getAllReportedJobs() async {
    try {
      return await remoteDataSource.getAllReportedJobs();
    } catch (e) {
      throw Exception('Failed to fetch reported jobs: ${e.toString()}');
    }
  }

  @override
  Future<ReportedJobModel> getReportById(String id) async {
    try {
      return await remoteDataSource.fetchReportById(id);
    } catch (e) {
      throw Exception('Failed to fetch report: $e');
    }
  }

  @override
  Future<List<ReportedJobModel>> getReportsByUser(String userId) async {
    try {
      return await remoteDataSource.fetchReportsByUser(userId);
    } catch (e) {
      throw Exception('Failed to get reports by user: $e');
    }
  }


  @override
  Future<List<ReportedJobModel>> getReportsByJob(String jobId) async {
    try {
      return await remoteDataSource.fetchReportsByJob(jobId);
    } catch (e) {
      throw Exception('Failed to get reports by job: $e');
    }
  }
}
