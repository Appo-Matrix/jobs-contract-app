import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../data/models/auth/send_otp_sms_req.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/repository/auth_repository.dart';
import 'package:job_contracts/utils/constants/colors.dart';

class SendOtpSmsProvider with ChangeNotifier {
  final AuthRepository authRepository = AuthRepositoryImpl();

  TextEditingController phoneNumberController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  String? _receivedOtp;
  String? get receivedOtp => _receivedOtp;

  Future<void> sendOtpSms(BuildContext context) async {
    if (phoneNumberController.text.isEmpty) {
      _errorMessage = 'Please enter your phone number';
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
      final request = SendOtpSmsRequest(phoneNumber: phoneNumberController.text);
      final response = await authRepository.sendOtpSms(request);
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

  void resetFields() {
    phoneNumberController.clear();
    _receivedOtp = null;
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }
}
