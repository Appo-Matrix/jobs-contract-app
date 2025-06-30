
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_contracts/data/repositories/job_repository_impl.dart';

import '../../../../data/models/jobs/create_job_request.dart';
import '../../../../data/models/jobs/job_detail_model.dart';
import '../../../../data/models/jobs/job_metrics_model.dart';
import '../../../../data/models/jobs/job_model.dart';
import '../../../../data/models/jobs/pagination_job_model.dart';
import '../../../../domain/repository/job_repository.dart';

class JobProvider with ChangeNotifier {
  final JobRepository repository=JobRepositoryImpl();


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

  Future<void> fetchJobById(String jobId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _job = await repository.getJobById(jobId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateJob(String id, JobDetailModel data) async {
    _isLoading = true;
    notifyListeners();

    try {
      _updatedJob = await repository.updateJob(id, data);
      Fluttertoast.showToast(msg: "Job updated successfully");
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchJobs({
    int page = 1,
    int limit = 10,
    String sortBy = 'date',
    String sortOrder = 'desc',
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      _paginatedJobs = await repository.getAllJobs(
        page: page,
        limit: limit,
        sortBy: sortBy,
        sortOrder: sortOrder,
      );
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
