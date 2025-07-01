import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../data/models/preferences/delete_preferences_response_model.dart';
import '../../../../data/models/preferences/real_estate_preferences_model.dart';
import '../../../../data/models/preferences/user_preference_user_model.dart';
import '../../../../data/models/preferences/user_preferences_model.dart';
import '../../../../data/repositories/preferences_repository_impl.dart';
import '../../../../domain/repository/preferences_repository.dart';


class PreferencesProvider with ChangeNotifier {
  final PreferencesRepository repository = PreferencesRepositoryImpl();

  bool _isLoading = false;
  String? _errorMessage;
  DeletePreferencesResponseModel? _deleteResponse;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  DeletePreferencesResponseModel? get deleteResponse => _deleteResponse;

  UserPreferencesModel? _preferences;
  UserPreferencesModel? get preferences => _preferences;

  List<PreferenceUserModel> _usersByPreference = [];
  List<PreferenceUserModel> get usersByPreference => _usersByPreference;

  RealEstatePreferencesModel? preferencesReal;


  Future<void> deletePreferences(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _deleteResponse = await repository.deleteUserPreferences(userId);
      _errorMessage = null;
      Fluttertoast.showToast(msg: _deleteResponse!.message);
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserPreferences(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _preferences = await repository.getUserPreferences(userId);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> searchUsersByJobPreference(String job) async {
    _isLoading = true;
    notifyListeners();

    try {
      _usersByPreference = await repository.searchUsersByJobPreference(job);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePreferences(RealEstatePreferencesModel model) async {
    _isLoading = true;
    notifyListeners();

    try {
      preferencesReal = await repository.updatePreferences(model);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
