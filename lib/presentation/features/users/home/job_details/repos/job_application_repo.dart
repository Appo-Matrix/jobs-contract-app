import '../models/job_application_model_new.dart';

abstract class JobApplicationRepo {
  Future<JobApplicationResponseModelNew> submitJobApplication({
    required String jobId,
    required String coverLetter,
  });
}