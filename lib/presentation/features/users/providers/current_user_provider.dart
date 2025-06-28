import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../data/models/user/current_user_res.dart';
import '../../../../data/models/user/update_current_user_profile_req.dart';
import '../../../../data/repositories/user_repository_impl.dart';
import '../../../../domain/repository/user_repository.dart';
import '../../../../utils/constants/colors.dart';


class CurrentUserProvider with ChangeNotifier {
  final UserRepository _repository = UserRepositoryImpl();

  CurrentUser? _currentUser;
  bool _isLoading = false;
  String _errorMessage = '';

  CurrentUser? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchCurrentUser() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _currentUser = await _repository.getCurrentUser();
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(
        msg: _errorMessage,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: JAppColors.primary,
        textColor: Colors.white,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateCurrentUserProfile(UpdateCurrentUserProfileRequest request) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _currentUser = await _repository.updateCurrentUserProfile(request);
      Fluttertoast.showToast(
        msg: "Profile updated",
        backgroundColor: JAppColors.primary,
        textColor: Colors.white,
      );
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(
        msg: _errorMessage,
        backgroundColor: JAppColors.error900,
        textColor: Colors.white,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
