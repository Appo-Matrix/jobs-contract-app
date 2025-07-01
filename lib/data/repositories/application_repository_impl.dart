
import '../../../domain/repository/application_repository.dart';
import '../data_source/remote/application_rds.dart';
import '../models/job_applications/job_application_model.dart';
import '../models/job_applications/job_application_response.dart';
import '../models/job_applications/job_application_response_model.dart';
import '../models/job_applications/job_application_submit_request.dart';
import '../models/job_applications/update_application_request.dart';

class ApplicationRepositoryImpl implements ApplicationRepository {
  final ApplicationRemoteDataSource remoteDataSource = ApplicationRemoteDataSource();

  @override
  Future<JobApplicationModel> getApplicationById(String id) async {
    try {
      return await remoteDataSource.getApplicationById(id);
    } catch (e) {
      throw Exception('Failed to fetch job application: $e');
    }
  }

  @override
  Future<void> deleteApplication(String id) async {
    try {
      await remoteDataSource.deleteApplication(id);
    } catch (e) {
      throw Exception('Failed to delete job application: $e');
    }
  }

  @override
  Future<JobApplicationModel> updateApplication(String id, UpdateApplicationRequest request) {
    try {
      return remoteDataSource.updateApplication(id, request);
    } catch (e){
      throw Exception('Failed to update job application: $e');

    }
  }

  @override
  Future<JobApplicationResponse> getApplicationsByJobId(String jobId) async {
    try {
      return await remoteDataSource.getApplicationsByJobId(jobId);
    } catch (error) {
      throw Exception('Error fetching applications: $error');
    }
  }

  @override
  Future<JobApplicationResponse> getMyJobApplications() async {
    try {
      return await remoteDataSource.getMyJobApplications();
    } catch (error) {
      throw Exception('Error retrieving user applications: $error');
    }
  }

  @override
  Future<JobApplicationResponseModel> submitJobApplication(JobApplicationSubmitRequest request) async {
    try {
      return await remoteDataSource.submitJobApplication(request);
    } catch (error) {
      throw Exception('Failed to submit job application: $error');
    }
  }
}
