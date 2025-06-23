import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../data/models/auth/google_signin_req.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/repository/auth_repository.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import '../../../../core/constants/keys/secure_storage_keys.dart';
import '../../../../domain/services/secure_storage_service.dart';

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

    context.loaderOverlay.show();
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
      SecureStorageService.save(SecureStorageKeys.authToken, response.accessToken);

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
