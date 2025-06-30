// providers/qualification_provider.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_contracts/data/repositories/qualification_repository_impl.dart';
import 'package:job_contracts/domain/repository/qualification_repository.dart';

import '../../../../data/models/education/education_model.dart';
import '../../../../data/models/education/qualification_model.dart';
import '../../../../data/models/education/qualification_request.dart';
import '../../../../data/models/education/user_education_model.dart';


class QualificationProvider with ChangeNotifier {
  final QualificationRepository _repository=QualificationRepositoryImpl();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<QualificationModel> _qualifications = [];
  List<QualificationModel> get qualifications => _qualifications;


  List<UserEducationModel> _myQualifications = [];
  List<UserEducationModel> get myQualifications => _myQualifications;


  Future<void> addQualification(QualificationRequest request) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _repository.addQualification(request);
      Fluttertoast.showToast(msg: response.message);
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> deleteQualification(String eduId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.deleteQualification(eduId);
      Fluttertoast.showToast(msg: 'Education entry deleted successfully');
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  EducationModel? _qualification;
  EducationModel? get qualification => _qualification;


  Future<void> fetchQualificationById(String eduId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _qualification = await _repository.getQualificationById(eduId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ✅ Update Qualification (NEW METHOD)
  Future<void> updateQualification(String eduId, EducationModel updatedData) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updated = await _repository.updateQualification(eduId, updatedData);
      _qualification = updated;
      Fluttertoast.showToast(msg: "Education entry updated successfully");
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchQualificationsByUserId(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _qualifications = await _repository.getQualificationsByUserId(userId);
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMyQualifications() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _myQualifications = await _repository.getMyQualifications();
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
