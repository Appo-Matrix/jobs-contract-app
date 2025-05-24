import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../data/models/auth/send_otp_email_req.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/repository/auth_repository.dart';

class SendOtpProvider with ChangeNotifier {
  final AuthRepository authRepository = AuthRepositoryImpl();

  TextEditingController emailController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  String? _receivedOtp;
  String? get receivedOtp => _receivedOtp;

  Future<void> sendOtp(BuildContext context) async {
    if (emailController.text.isEmpty || !_isValidEmail(emailController.text)) {
      _errorMessage = 'Please enter a valid email';
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
      final request = SendOtpEmailRequest(email: emailController.text);
      final response = await authRepository.sendOtpEmail(request);
      _receivedOtp = response.otp;

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

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
        .hasMatch(email);
  }

  void resetFields() {
    emailController.clear();
    _receivedOtp = null;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
