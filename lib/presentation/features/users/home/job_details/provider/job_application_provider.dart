import 'package:flutter/material.dart';

import '../repos/job_application_repo.dart';
import '../repos/job_application_repo_impl.dart';

enum JobApplicationState { idle, loading, success, error }

class JobApplicationProvider extends ChangeNotifier {
  final JobApplicationRepo _repo;

  JobApplicationProvider({JobApplicationRepo? repo})
      : _repo = repo ?? JobApplicationRepoImpl();

  JobApplicationState _state = JobApplicationState.idle;
  String _errorMessage = '';

  JobApplicationState get state => _state;
  String get errorMessage => _errorMessage;

  bool get isLoading => _state == JobApplicationState.loading;
  bool get isSuccess => _state == JobApplicationState.success;
  bool get isError => _state == JobApplicationState.error;

  Future<bool> submitJobApplication({
    required String jobId,
    required String coverLetter,
  }) async {
    if (coverLetter.trim().isEmpty) {
      _errorMessage = 'Please write a cover letter before submitting.';
      _state = JobApplicationState.error;
      notifyListeners();
      return false;
    }

    _state = JobApplicationState.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      await _repo.submitJobApplication(
        jobId: jobId,
        coverLetter: coverLetter.trim(),
      );

      _state = JobApplicationState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _state = JobApplicationState.error;

      notifyListeners();
      return false;
    }
  }

  void resetState() {
    _state = JobApplicationState.idle;
    _errorMessage = '';
    notifyListeners();
  }
}