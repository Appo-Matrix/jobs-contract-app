import 'package:flutter/material.dart';
import 'package:job_contracts/data/repositories/reports_repository_impl.dart';

import '../../../../data/models/reported_jobs/reported_jobs_model.dart';
import '../../../../domain/repository/reports_repository.dart';

class ReportsProvider with ChangeNotifier {
  final ReportsRepository reportsRepository= ReportsRepositoryImpl();


  bool _isLoading = false;
  String _errorMessage = '';
  List<ReportedJobModel> _reportedJobs = [];

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<ReportedJobModel> get reportedJobs => _reportedJobs;

  ReportedJobModel? _report;
  ReportedJobModel? get report => _report;

  List<ReportedJobModel> _reports = [];
  List<ReportedJobModel> get reports => _reports;




  Future<void> fetchAllReportedJobs() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _reportedJobs = await reportsRepository.getAllReportedJobs();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchReport(String id) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _report = await reportsRepository.getReportById(id);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchReportsByUser(String userId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _reports = await reportsRepository.getReportsByUser(userId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchReportsByJob(String jobId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _reports = await reportsRepository.getReportsByJob(jobId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
