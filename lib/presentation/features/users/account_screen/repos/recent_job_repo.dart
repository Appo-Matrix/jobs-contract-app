import '../models/recent_job_model.dart';

abstract class RecentJobRepo {
  /// Fetches recently posted jobs from the API.
  /// Returns a [RecentJobResponse] on success.
  /// Throws an [Exception] on failure.
  Future<RecentJobResponse> fetchRecentJobs();
}