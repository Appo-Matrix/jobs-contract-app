 import '../../data/models/auth/foget_pass_res.dart';
import '../../data/models/auth/forget_pass_req.dart';
import '../../data/models/auth/google_sigin_res.dart';
import '../../data/models/auth/google_signin_req.dart';
import '../../data/models/auth/login_req.dart';
import '../../data/models/auth/login_res.dart';
import '../../data/models/auth/register_user_req.dart';
import '../../data/models/auth/register_user_res.dart';
import '../../data/models/auth/reset_password_req.dart';
import '../../data/models/auth/reset_password_res.dart';
import '../../data/models/auth/send_otp_email_req.dart';
import '../../data/models/auth/send_otp_email_res.dart';
import '../../data/models/auth/send_otp_sms_req.dart';
import '../../data/models/auth/send_otp_sms_res.dart';
import '../../data/models/auth/update_password_req.dart';
import '../../data/models/auth/update_password_res.dart';

abstract class AuthRepository {

  Future<LoginResponse> login(LoginRequest request);

  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest request);

  Future<RegisterUserResponse> registerUser(RegisterUserRequest request);

  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request);

  Future<SendOtpEmailResponse> sendOtpEmail(SendOtpEmailRequest request);

  Future<SendOtpSmsResponse> sendOtpSms(SendOtpSmsRequest request);

  Future<GoogleSignInResponse> signInWithGoogle(GoogleSignInRequest request);

  Future<UpdatePasswordResponse> updatePassword(UpdatePasswordRequest request);

  Future<bool> logout();



}