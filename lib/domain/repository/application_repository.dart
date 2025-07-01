import '../../data/models/job_applications/job_application_model.dart';
import '../../data/models/job_applications/job_application_response.dart';
import '../../data/models/job_applications/job_application_response_model.dart';
import '../../data/models/job_applications/job_application_submit_request.dart';
import '../../data/models/job_applications/update_application_request.dart';

abstract class ApplicationRepository {

  Future<JobApplicationModel> getApplicationById(String id);

  Future<void> deleteApplication(String id);

  Future<JobApplicationModel> updateApplication(String id, UpdateApplicationRequest request);

  Future<JobApplicationResponse> getApplicationsByJobId(String jobId);

  Future<JobApplicationResponse> getMyJobApplications();

  Future<JobApplicationResponseModel> submitJobApplication(JobApplicationSubmitRequest request);

}
