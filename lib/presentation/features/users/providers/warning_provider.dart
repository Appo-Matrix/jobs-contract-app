import 'package:flutter/material.dart';
import 'package:job_contracts/data/repositories/warning_repository_impl.dart';

import '../../../../data/models/warnings/delete_warning_res.dart';
import '../../../../data/models/warnings/issue_warning_req.dart';
import '../../../../data/models/warnings/issue_warning_res.dart';
import '../../../../data/models/warnings/user_warning.dart';
import '../../../../data/models/warnings/warning_model.dart';
import '../../../../domain/repository/warning_repository.dart';

class WarningProvider with ChangeNotifier {
  final WarningRepository repository = WarningRepositoryImpl();

  bool _isLoading = false;
  String? _error;
  IssueWarningResponse? _response;

  bool get isLoading => _isLoading;
  String? get error => _error;
  IssueWarningResponse? get response => _response;

  DeleteWarningResponse? _deleteResponse;
  DeleteWarningResponse? get deleteResponse => _deleteResponse;

  List<WarningModel> _warnings = [];
  List<WarningModel> get warnings => _warnings;

  List<UserWarning> _userWarnings = [];
  List<UserWarning> get userWarnings => _userWarnings;




  Future<void> issueWarning(IssueWarningRequest request) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _response = await repository.issueWarning(request);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteWarning(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _deleteResponse = await repository.deleteWarning(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> fetchWarnings() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _warnings = await repository.getMyWarnings();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserWarnings(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _userWarnings = await repository.getWarningsByUserId(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
