import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_contracts/data/repositories/job_repository_impl.dart';

import '../../../../data/models/jobs/create_job_request.dart';
import '../../../../data/models/jobs/job_detail_model.dart';
import '../../../../data/models/jobs/job_list_item_model.dart';
import '../../../../data/models/jobs/job_metrics_model.dart';
import '../../../../data/models/jobs/job_model.dart';
import '../../../../data/models/jobs/job_report_model.dart';
import '../../../../data/models/jobs/job_search_result_model.dart';
import '../../../../data/models/jobs/matched_job_model.dart';
import '../../../../data/models/jobs/recent_job_model.dart';
import '../../../../data/models/saved_jobs/saved_jobs_model.dart';
import '../../../../data/models/saved_jobs/toggle_saved_jobs_req.dart';
import '../../../../domain/repository/job_repository.dart';

class JobProvider with ChangeNotifier {
  final JobRepository repository = JobRepositoryImpl();

  bool _isLoading = false;
  String? _errorMessage;
  JobModel? _createdJob;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  JobModel? get createdJob => _createdJob;
  String? get successMessage => _successMessage;

  JobDetailModel? _updatedJob;
  JobDetailModel? get updatedJob => _updatedJob;

  List<JobListItemModel> _jobs = [];
  List<JobListItemModel> get jobs => _jobs;

  List<MatchedJobModel> _matchedJobs = [];
  List<MatchedJobModel> get matchedJobs => _matchedJobs;

  List<RecentJobModel> _recentJobs = [];
  List<RecentJobModel> get recentJobs => _recentJobs;

  List<JobSearchResultModel> _searchResults = [];
  List<JobSearchResultModel> get searchResults => _searchResults;

  List<SavedJobModel> _savedJobs = [];
  List<SavedJobModel> get savedJobs => _savedJobs;

  PaginatedJobsModel? _paginatedJobs;
  PaginatedJobsModel? get paginatedJobs => _paginatedJobs;

  JobMetricsModel? _metrics;
  JobMetricsModel? get metrics => _metrics;

  Future<void> createJob(CreateJobRequest request) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _createdJob = await repository.createJob(request);
      Fluttertoast.showToast(msg: "Job created successfully");
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadJobMetrics() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _metrics = await repository.fetchJobMetrics();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteJob(String jobId) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final message = await repository.deleteJob(jobId);
      _successMessage = message;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  JobDetailModel? _job;
  JobDetailModel? get job => _job;

  Future<void> fetchJobs({
    int page = 1,
    int limit = 10,
    String sortBy = 'date',
    String sortOrder = 'desc',
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      print('📡 Fetching jobs - Page: $page, Limit: $limit');

      _paginatedJobs = await repository.getAllJobs(
        page: page,
        limit: limit,
        sortBy: sortBy,
        sortOrder: sortOrder,
      );

      print('✅ Jobs fetched successfully');
      print('📊 Total jobs: ${_paginatedJobs?.pagination.totalJobs ?? 0}');
      print('📄 Current page: ${_paginatedJobs?.pagination.currentPage ?? 0}');
      print('📋 Jobs in this response: ${_paginatedJobs?.jobs.length ?? 0}');

      if (_paginatedJobs?.jobs.isEmpty ?? true) {
        print('⚠️ No jobs found in the response');
      } else {
        print('📝 First job title: ${_paginatedJobs?.jobs.first.title}');
      }

    } catch (e) {
      _errorMessage = e.toString();
      print('❌ Error fetching jobs: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:job_contracts/data/repositories/job_repository_impl.dart';
//
// import '../../../../data/models/jobs/create_job_request.dart';
// import '../../../../data/models/jobs/job_detail_model.dart';
// import '../../../../data/models/jobs/job_list_item_model.dart';
// import '../../../../data/models/jobs/job_metrics_model.dart';
// import '../../../../data/models/jobs/job_model.dart';
// import '../../../../data/models/jobs/job_report_model.dart';
// import '../../../../data/models/jobs/job_search_result_model.dart';
// import '../../../../data/models/jobs/matched_job_model.dart';
// import '../../../../data/models/jobs/pagination_job_model.dart' hide PaginatedJobsModel;
// import '../../../../data/models/jobs/recent_job_model.dart';
// import '../../../../data/models/saved_jobs/saved_jobs_model.dart';
// import '../../../../data/models/saved_jobs/toggle_saved_jobs_req.dart';
// import '../../../../domain/repository/job_repository.dart';
//
// class JobProvider with ChangeNotifier {
//   final JobRepository repository=JobRepositoryImpl();
//
//
//   bool _isLoading = false;
//   String? _errorMessage;
//   JobModel? _createdJob;
//   String? _successMessage;
//
//
//
//
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   JobModel? get createdJob => _createdJob;
//   String? get successMessage => _successMessage;
//
//
//   JobDetailModel? _updatedJob;
//   JobDetailModel? get updatedJob => _updatedJob;
//
//   List<JobListItemModel> _jobs = [];
//   List<JobListItemModel> get jobs => _jobs;
//
//   List<MatchedJobModel> _matchedJobs = [];
//   List<MatchedJobModel> get matchedJobs => _matchedJobs;
//
//   List<RecentJobModel> _recentJobs = [];
//   List<RecentJobModel> get recentJobs => _recentJobs;
//
//   List<JobSearchResultModel> _searchResults = [];
//   List<JobSearchResultModel> get searchResults => _searchResults;
//
//
//   List<SavedJobModel> _savedJobs = [];
//   List<SavedJobModel> get savedJobs => _savedJobs;
//
//
//
//
//   PaginatedJobsModel? _paginatedJobs;
//
//   PaginatedJobsModel? get paginatedJobs => _paginatedJobs;
//
//
//
//   JobMetricsModel? _metrics;
//
//
//   JobMetricsModel? get metrics => _metrics;
//
//   Future<void> createJob(CreateJobRequest request) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();
//
//     try {
//       _createdJob = await repository.createJob(request);
//       Fluttertoast.showToast(msg: "Job created successfully");
//     } catch (e) {
//       _errorMessage = e.toString();
//       Fluttertoast.showToast(msg: _errorMessage!);
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> loadJobMetrics() async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();
//
//     try {
//       _metrics = await repository.fetchJobMetrics();
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//
//   Future<void> deleteJob(String jobId) async {
//     _isLoading = true;
//     _errorMessage = null;
//     _successMessage = null;
//     notifyListeners();
//
//     try {
//       final message = await repository.deleteJob(jobId);
//       _successMessage = message;
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   JobDetailModel? _job;
//   JobDetailModel? get job => _job;
//
//   Future<void> fetchJobById(String jobId) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();
//
//     try {
//       _job = await repository.getJobById(jobId);
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> updateJob(String id, JobDetailModel data) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _updatedJob = await repository.updateJob(id, data);
//       Fluttertoast.showToast(msg: "Job updated successfully");
//     } catch (e) {
//       _errorMessage = e.toString();
//       Fluttertoast.showToast(msg: _errorMessage!);
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> fetchJobs({
//     int page = 1,
//     int limit = 10,
//     String sortBy = 'date',
//     String sortOrder = 'desc',
//   }) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _paginatedJobs = await repository.getAllJobs(
//         page: page,
//         limit: limit,
//         sortBy: sortBy,
//         sortOrder: sortOrder,
//       );
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//
//   Future<void> fetchMyPostedJobs() async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();
//
//     try {
//       _jobs = await repository.getMyPostedJobs();
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//
//   Future<void> fetchMatchedJobs() async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _matchedJobs = await repository.getMatchedJobs();
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//
//   Future<void> fetchRecentJobs({int page = 1, int limit = 10}) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _recentJobs = await repository.getRecentJobs(page: page, limit: limit);
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//
//   Future<void> searchJobs(Map<String, String> filters) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _searchResults = await repository.searchJobs(filters);
//       _errorMessage = null;
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//
//   Future<void> reportJob(JobReportModel report) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       final result = await repository.reportJob(report);
//       Fluttertoast.showToast(msg: 'Job reported successfully');
//     } catch (e) {
//       _errorMessage = e.toString();
//       Fluttertoast.showToast(msg: _errorMessage!);
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> fetchSavedJobs() async {
//     _isLoading = true;
//     _errorMessage = '';
//     notifyListeners();
//
//     try {
//       _savedJobs = await repository.fetchSavedJobs();
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> toggleSaveJob(String jobId, String userId) async {
//     _isLoading = true;
//     _errorMessage = '';
//     notifyListeners();
//
//     try {
//       final request = ToggleSaveJobRequest(jobId: jobId, userId: userId);
//       final response = await repository.toggleJobSaveStatus(request);
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
