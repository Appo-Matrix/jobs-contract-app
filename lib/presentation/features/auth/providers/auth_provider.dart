import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_contracts/data/models/auth/forget_pass_req.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/constants/keys/secure_storage_keys.dart';
import '../../../../data/models/auth/fcm_token_req.dart';
import '../../../../data/models/auth/login_req.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/repository/auth_repository.dart';
import '../../../../domain/services/secure_storage_service.dart';

class AuthProvider with ChangeNotifier{

  final AuthRepository authRepository = AuthRepositoryImpl();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;


  void updateEmail(String email) {
    emailController.text = email;
    notifyListeners();
  }

  Future<void> loginWithEmail(BuildContext context) async {
    if (emailController.text.isEmpty || !_isValidEmail(emailController.text)) {
      _errorMessage = 'Please enter a valid email';
      Fluttertoast.showToast(
          msg: _errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);

      notifyListeners();
      return;
    }
    context.loaderOverlay.show();
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final loginRequest = LoginRequest(email: emailController.text,password: passwordController.text);
      final response = await authRepository.login(loginRequest);
      SecureStorageService.save(SecureStorageKeys.authToken, response.token);
      debugPrint('Login response token: ${response.token}');
      // ignore: use_build_context_synchronously
      //context.go('/otpScreen');
      Fluttertoast.showToast(
          msg: "Login email token: ${response.token}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (error) {
      _errorMessage = 'Error: $error';
      Fluttertoast.showToast(
          msg: 'Something went wrong => Error: $error',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: JAppColors.white,
          fontSize: 16.0);
    } finally {
      // ignore: use_build_context_synchronously
      context.loaderOverlay.hide();
      _isLoading = false;
      notifyListeners();
    }

    resetInputField();
  }

  Future<void> forgetPassword(BuildContext context) async {
    if (emailController.text.isEmpty || !_isValidEmail(emailController.text)) {
      _errorMessage = 'Please enter a valid email';
      Fluttertoast.showToast(
          msg: _errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);

      notifyListeners();
      return;
    }
    context.loaderOverlay.show();
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final forgetPassRequest = ForgotPasswordRequest(email: emailController.text);
      final response = await authRepository.forgotPassword(forgetPassRequest);


    } catch (error) {
      _errorMessage = 'Error: $error';
      Fluttertoast.showToast(
          msg: 'Something went wrong => Error: $error',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: JAppColors.white,
          fontSize: 16.0);
    } finally {
      // ignore: use_build_context_synchronously
      context.loaderOverlay.hide();
      _isLoading = false;
      notifyListeners();
    }

    resetInputField();


  }

  Future<void> logoutUser(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final success = await authRepository.logout();
      if (success) {
        // Clear local storage, navigate to login, etc.
       // await SecureStorageService.clearAll();
        Fluttertoast.showToast(
          msg: "Logout successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        // Optionally navigate or reset UI
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Logout error: $error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
        .hasMatch(email);
  }

  void resetInputField() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  Future<void> registerToken(String email, String token) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final request = FcmTokenRequest(email: email, fcmToken: token);
      await authRepository.registerFcmToken(request);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}