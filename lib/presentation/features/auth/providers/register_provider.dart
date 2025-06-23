import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:job_contracts/utils/constants/colors.dart';

import '../../../../data/models/auth/register_user_req.dart';
import '../../../../domain/repository/auth_repository.dart';
import '../../../../data/repositories/auth_repository_impl.dart';

class RegisterProvider with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepositoryImpl();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userTypeController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void updateEmail(String email) {
    emailController.text = email;
    notifyListeners();
  }

  Future<void> registerUser(BuildContext context) async {
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
      final request = RegisterUserRequest(
        fullName: fullNameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        userType: userTypeController.text,
        password: passwordController.text,
        location: Location(type: "Point", coordinates: [40.7128, -74.006]), // You can pass real coordinates from UI
      );

      final response = await _authRepository.registerUser(request);
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

    resetFields();
  }

  bool _validateInputs() {
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        !_isValidEmail(emailController.text) ||
        phoneNumberController.text.isEmpty ||
        passwordController.text.length < 6 ||
        userTypeController.text.isEmpty) {
      _errorMessage = 'Please fill all fields with valid data';
      return false;
    }
    return true;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
        .hasMatch(email);
  }

  void resetFields() {
    fullNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    passwordController.clear();
    userTypeController.clear();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    userTypeController.dispose();
    super.dispose();
  }
}
