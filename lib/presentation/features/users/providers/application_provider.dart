// providers/application_provider.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../data/models/job_applications/job_application_model.dart';
import '../../../../data/models/job_applications/job_application_response.dart';
import '../../../../data/models/job_applications/job_application_response_model.dart';
import '../../../../data/models/job_applications/job_application_submit_request.dart';
import '../../../../data/models/job_applications/update_application_request.dart';
import '../../../../data/repositories/application_repository_impl.dart';
import '../../../../domain/repository/application_repository.dart';


class ApplicationProvider with ChangeNotifier {
  final ApplicationRepository _repository = ApplicationRepositoryImpl();

  JobApplicationModel? _application;
  JobApplicationModel? get application => _application;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  JobApplicationModel? _updatedApplication;
  JobApplicationModel? get updatedApplication => _updatedApplication;

  JobApplicationResponse? _jobApplications;
  JobApplicationResponse? get jobApplications => _jobApplications;

  JobApplicationResponse? _myApplications;
  JobApplicationResponse? get myApplications => _myApplications;

  JobApplicationResponseModel? _applicationResponse;
  JobApplicationResponseModel? get applicationResponse => _applicationResponse;


  String? _error;
  String? get error => _error;

  Future<void> fetchApplicationById(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _application = await _repository.getApplicationById(id);
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(msg: _error ?? 'Error fetching application');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteApplication(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.deleteApplication(id);
      Fluttertoast.showToast(
        msg: "Job application deleted successfully",
        toastLength: Toast.LENGTH_SHORT,
      );
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(
        msg: _error!,
        toastLength: Toast.LENGTH_SHORT,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateApplication(String id, UpdateApplicationRequest request) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _updatedApplication = await _repository.updateApplication(id, request);
      Fluttertoast.showToast(
        msg: "Application updated successfully",
        toastLength: Toast.LENGTH_SHORT,
      );
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(
        msg: _error!,
        toastLength: Toast.LENGTH_SHORT,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchApplicationsByJobId(String jobId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _jobApplications = await _repository.getApplicationsByJobId(jobId);
      _error = null;
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(msg: _error!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMyJobApplications() async {
    _isLoading = true;
    notifyListeners();

    try {
      _myApplications = await _repository.getMyJobApplications();
      _error = null;
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(msg: _error!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> submitApplication(JobApplicationSubmitRequest request) async {
    _isLoading = true;
    notifyListeners();

    try {
      _applicationResponse = await _repository.submitJobApplication(request);
      _error = null;
      Fluttertoast.showToast(msg: _applicationResponse!.message);
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(msg: _error!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
