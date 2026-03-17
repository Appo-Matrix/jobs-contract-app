import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import '../../../../data/repositories/job_repository_impl.dart';
import '../../../../domain/repository/job_repository.dart';

class JobProvider with ChangeNotifier {
  final JobRepository repository = JobRepositoryImpl();

  // ─── Existing State Variables (UNCHANGED) ─────────────────────────────────

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

  JobDetailModel? _job;
  JobDetailModel? get job => _job;

  // ─── Existing: Create Job (UNCHANGED) ─────────────────────────────────────

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

  // ─── Existing: Load Job Metrics (UNCHANGED) ────────────────────────────────

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

  // ─── Existing: Delete Job (UNCHANGED) ─────────────────────────────────────

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

  // ─── Existing: Fetch Jobs (UNCHANGED) ─────────────────────────────────────

  Future<void> fetchJobs({
    int page = 1,
    int limit = 1000,           // high limit to get all jobs at once
    String sortBy = 'createdAt', // sort by latest date
    String sortOrder = 'desc',   // latest first by default
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      print('📡 Fetching all jobs - SortBy: $sortBy, SortOrder: $sortOrder');

      int currentPage = 1;
      bool hasMorePages = true;
      List<JobListItemModel> allJobs = [];
      PaginatedJobsModel? lastResult;

      while (hasMorePages) {
        print('📄 Fetching page $currentPage...');

        final result = await repository.getAllJobs(
          page: currentPage,
          limit: limit,
          sortBy: sortBy,
          sortOrder: sortOrder,
        );

        if (result == null) break;

        lastResult = result;
        allJobs.addAll(result.jobs);

        final totalPages = result.pagination.totalPages;
        hasMorePages = currentPage < totalPages;
        currentPage++;

        print('📋 Page $currentPage done | Collected so far: ${allJobs.length}');
      }

      // Merge all pages into single PaginatedJobsModel
      if (lastResult != null) {
        _paginatedJobs = PaginatedJobsModel(
          jobs: allJobs,
          pagination: lastResult.pagination,
        );
      }

      print('✅ All jobs fetched successfully');
      print('📊 Total jobs: ${_paginatedJobs?.pagination.totalJobs ?? 0}');
      print('📋 Jobs collected: ${allJobs.length}');

      if (allJobs.isEmpty) {
        print('⚠️ No jobs found in the response');
      } else {
        print('📝 First job title: ${allJobs.first.title}');
      }

    } catch (e) {
      _errorMessage = e.toString();
      print('❌ Error fetching jobs: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── NEW: Fetch All Jobs All Pages Latest First ────────────────────────────

  Future<void> fetchAllJobs() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      print('📡 Fetching all jobs sorted by latest date...');

      int currentPage = 1;
      bool hasMorePages = true;
      List<JobListItemModel> allJobs = [];
      PaginatedJobsModel? lastResult;

      while (hasMorePages) {
        print('📄 Fetching page $currentPage...');

        final result = await repository.getAllJobs(
          page: currentPage,
          limit: 20,
          sortBy: 'createdAt',
          sortOrder: 'desc',
        );

        if (result == null) break;

        lastResult = result;
        allJobs.addAll(result.jobs);

        final totalPages = result.pagination.totalPages;
        hasMorePages = currentPage < totalPages;
        currentPage++;

        print('✅ Page $currentPage fetched | Total so far: ${allJobs.length}');
      }

      if (lastResult != null) {
        _paginatedJobs = PaginatedJobsModel(
          jobs: allJobs,
          pagination: lastResult.pagination,
        );
      }

      print('🎉 All jobs loaded: ${allJobs.length}');

      if (allJobs.isEmpty) {
        print('⚠️ No jobs found');
      } else {
        print('📝 First job title: ${allJobs.first.title}');
      }

    } catch (e) {
      _errorMessage = e.toString();
      print('❌ Error fetching all jobs: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── NEW: Fetch Job By ID ──────────────────────────────────────────────────

  // Future<void> fetchJobById(String jobId) async {
  //   _isLoading = true;
  //   _errorMessage = null;
  //   notifyListeners();
  //
  //   try {
  //     _job = await repository.getJobById(jobId);
  //     print('✅ Job fetched: ${_job?.title}');
  //   } catch (e) {
  //     _errorMessage = e.toString();
  //     print('❌ Error fetching job by ID: $e');
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
  //
  // // ─── NEW: Update Job ───────────────────────────────────────────────────────
  //
  // Future<void> updateJob(String id, JobDetailModel data) async {
  //   _isLoading = true;
  //   _errorMessage = null;
  //   notifyListeners();
  //
  //   try {
  //     _updatedJob = await repository.updateJob(id, data);
  //     Fluttertoast.showToast(msg: "Job updated successfully");
  //     print('✅ Job updated: ${_updatedJob?.title}');
  //   } catch (e) {
  //     _errorMessage = e.toString();
  //     Fluttertoast.showToast(msg: _errorMessage!);
  //     print('❌ Error updating job: $e');
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // ─── NEW: Fetch My Posted Jobs ─────────────────────────────────────────────

  Future<void> fetchMyPostedJobs() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _jobs = await repository.getMyPostedJobs();
      print('✅ My posted jobs fetched: ${_jobs.length}');
    } catch (e) {
      _errorMessage = e.toString();
      print('❌ Error fetching my posted jobs: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── NEW: Fetch Matched Jobs ───────────────────────────────────────────────

  Future<void> fetchMatchedJobs() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _matchedJobs = await repository.getMatchedJobs();
      print('✅ Matched jobs fetched: ${_matchedJobs.length}');
    } catch (e) {
      _errorMessage = e.toString();
      print('❌ Error fetching matched jobs: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── NEW: Fetch Recent Jobs ────────────────────────────────────────────────

  Future<void> fetchRecentJobs({int page = 1, int limit = 10}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _recentJobs = await repository.getRecentJobs(
        page: page,
        limit: limit,
      );
      print('✅ Recent jobs fetched: ${_recentJobs.length}');
    } catch (e) {
      _errorMessage = e.toString();
      print('❌ Error fetching recent jobs: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── NEW: Search Jobs ──────────────────────────────────────────────────────

  Future<void> searchJobs(Map<String, String> filters) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _searchResults = await repository.searchJobs(filters);
      print('✅ Search results: ${_searchResults.length}');
    } catch (e) {
      _errorMessage = e.toString();
      print('❌ Error searching jobs: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── NEW: Report Job ───────────────────────────────────────────────────────

  Future<void> reportJob(JobReportModel report) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await repository.reportJob(report);
      Fluttertoast.showToast(msg: 'Job reported successfully');
      print('✅ Job reported successfully');
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
      print('❌ Error reporting job: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── NEW: Fetch Saved Jobs ─────────────────────────────────────────────────

  Future<void> fetchSavedJobs() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _savedJobs = await repository.fetchSavedJobs();
      print('✅ Saved jobs fetched: ${_savedJobs.length}');
    } catch (e) {
      _errorMessage = e.toString();
      print('❌ Error fetching saved jobs: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── NEW: Toggle Save Job ──────────────────────────────────────────────────

  Future<void> toggleSaveJob(String jobId, String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final request = ToggleSaveJobRequest(jobId: jobId, userId: userId);
      await repository.toggleJobSaveStatus(request);
      print('✅ Job save status toggled for jobId: $jobId');

      // Refresh saved jobs list after toggle
      await fetchSavedJobs();
    } catch (e) {
      _errorMessage = e.toString();
      print('❌ Error toggling save job: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── NEW: Clear Error ──────────────────────────────────────────────────────

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // ─── NEW: Clear Success Message ────────────────────────────────────────────

  void clearSuccess() {
    _successMessage = null;
    notifyListeners();
  }
}

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import '../../../../data/models/jobs/create_job_request.dart';
// import '../../../../data/models/jobs/job_detail_model.dart';
// import '../../../../data/models/jobs/job_list_item_model.dart';
// import '../../../../data/models/jobs/job_metrics_model.dart';
// import '../../../../data/models/jobs/job_model.dart';
// import '../../../../data/models/jobs/job_report_model.dart';
// import '../../../../data/models/jobs/job_search_result_model.dart';
// import '../../../../data/models/jobs/matched_job_model.dart';
// import '../../../../data/models/jobs/recent_job_model.dart';
// import '../../../../data/models/saved_jobs/saved_jobs_model.dart';
// import '../../../../data/models/saved_jobs/toggle_saved_jobs_req.dart';
// import '../../../../data/repositories/job_repository_impl.dart';
// import '../../../../domain/repository/job_repository.dart';
//
// class JobProvider with ChangeNotifier {
//   final JobRepository repository = JobRepositoryImpl();
//
//   bool _isLoading = false;
//   String? _errorMessage;
//   JobModel? _createdJob;
//   String? _successMessage;
//
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   JobModel? get createdJob => _createdJob;
//   String? get successMessage => _successMessage;
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
//   List<SavedJobModel> _savedJobs = [];
//   List<SavedJobModel> get savedJobs => _savedJobs;
//
//   PaginatedJobsModel? _paginatedJobs;
//   PaginatedJobsModel? get paginatedJobs => _paginatedJobs;
//
//   JobMetricsModel? _metrics;
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
//   Future<void> fetchJobs({
//     int page = 1,
//     int limit = 10,
//     String sortBy = 'date',
//     String sortOrder = 'desc',
//   }) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();
//
//     try {
//       print('📡 Fetching jobs - Page: $page, Limit: $limit');
//
//       _paginatedJobs = await repository.getAllJobs(
//         page: page,
//         limit: limit,
//         sortBy: sortBy,
//         sortOrder: sortOrder,
//       );
//
//       print('✅ Jobs fetched successfully');
//       print('📊 Total jobs: ${_paginatedJobs?.pagination.totalJobs ?? 0}');
//       print('📄 Current page: ${_paginatedJobs?.pagination.currentPage ?? 0}');
//       print('📋 Jobs in this response: ${_paginatedJobs?.jobs.length ?? 0}');
//
//       if (_paginatedJobs?.jobs.isEmpty ?? true) {
//         print('⚠️ No jobs found in the response');
//       } else {
//         print('📝 First job title: ${_paginatedJobs?.jobs.first.title}');
//       }
//
//     } catch (e) {
//       _errorMessage = e.toString();
//       print('❌ Error fetching jobs: $e');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }