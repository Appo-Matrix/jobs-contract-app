import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:job_contracts/utils/constants/colors.dart';

import '../../../../data/models/auth/reset_password_req.dart';
import '../../../../domain/repository/auth_repository.dart';
import '../../../../data/repositories/auth_repository_impl.dart';

class ResetPasswordProvider with ChangeNotifier {
  final AuthRepository authRepository = AuthRepositoryImpl();

  TextEditingController emailController = TextEditingController();
  TextEditingController tokenController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> resetPassword(BuildContext context) async {
    if (!_validateInputs()) {
      Fluttertoast.showToast(
        msg: _errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      notifyListeners();
      return;
    }

    context.loaderOverlay.show();
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final request = ResetPasswordRequest(
        token: tokenController.text,
        email: emailController.text,
        newPassword: newPasswordController.text,
      );

      final response = await authRepository.resetPassword(request);

      Fluttertoast.showToast(
        msg: response.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (error) {
      _errorMessage = 'Error: $error';
      Fluttertoast.showToast(
        msg: 'Something went wrong => $_errorMessage',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: JAppColors.white,
        fontSize: 16.0,
      );
    } finally {
      context.loaderOverlay.hide();
      _isLoading = false;
      notifyListeners();
    }

    resetInputFields();
  }

  bool _validateInputs() {
    if (tokenController.text.isEmpty ||
        emailController.text.isEmpty ||
        !_isValidEmail(emailController.text) ||
        newPasswordController.text.length < 6) {
      _errorMessage = 'Please fill all fields with valid data';
      return false;
    }
    return true;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
        .hasMatch(email);
  }

  void resetInputFields() {
    emailController.clear();
    tokenController.clear();
    newPasswordController.clear();
  }

  @override
  void dispose() {
    emailController.dispose();
    tokenController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }
}
