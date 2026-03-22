import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../data/data_source/local/AuthPreferences.dart';
import '../../../../data/models/auth/google_signin_req.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/repository/auth_repository.dart';
import '../../../../utils/constants/colors.dart';

class GoogleSignInProvider with ChangeNotifier {
  final AuthRepository authRepository = AuthRepositoryImpl();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController photoController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> signInWithGoogle(BuildContext context) async {
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

    // Capture overlay before async gap
    final overlay = context.loaderOverlay;
    overlay.show();
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final request = GoogleSignInRequest(
        email: emailController.text,
        name: nameController.text,
        photo: photoController.text,
      );

      final response = await authRepository.signInWithGoogle(request);

      // Save token + user via AuthPreferences
      await AuthPreferences.saveSession(
        token: response.accessToken,
        user: response.user.toUser(),
      );

      debugPrint('✅ Google Sign-In session saved: ${emailController.text}');

      Fluttertoast.showToast(
        msg: response.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      resetFields();

    } catch (error) {
      _errorMessage = error.toString().replaceFirst('Exception: ', '');
      Fluttertoast.showToast(
        msg: 'Sign-in failed: $_errorMessage',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: JAppColors.white,
        fontSize: 16.0,
      );

    } finally {
      overlay.hide();
      _isLoading = false;
      notifyListeners();
    }
  }

  bool _validateInputs() {
    if (emailController.text.isEmpty ||
        nameController.text.isEmpty ||
        photoController.text.isEmpty) {
      _errorMessage = 'Please enter all fields';
      return false;
    }
    return true;
  }

  void resetFields() {
    emailController.clear();
    nameController.clear();
    photoController.clear();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    photoController.dispose();
    super.dispose();
  }
}