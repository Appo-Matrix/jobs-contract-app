import 'package:job_contracts/data/models/auth/foget_pass_res.dart';
import 'package:job_contracts/data/models/auth/forget_pass_req.dart';
import 'package:job_contracts/data/models/auth/register_user_req.dart';
import 'package:job_contracts/data/models/auth/register_user_res.dart';
import 'package:job_contracts/data/models/auth/reset_password_req.dart';
import 'package:job_contracts/data/models/auth/reset_password_res.dart';
import 'package:job_contracts/data/models/auth/send_otp_email_req.dart';
import 'package:job_contracts/data/models/auth/send_otp_email_res.dart';

import '../../domain/repository/auth_repository.dart';
import '../data_source/remote/auth_rds.dart';
import '../models/auth/google_sigin_res.dart';
import '../models/auth/google_signin_req.dart';
import '../models/auth/login_req.dart';
import '../models/auth/login_res.dart';
import '../models/auth/send_otp_sms_req.dart';
import '../models/auth/send_otp_sms_res.dart';
import '../models/auth/update_password_req.dart';
import '../models/auth/update_password_res.dart';

class AuthRepositoryImpl implements AuthRepository{

  final AuthRemoteDataSource authRemoteDataSource=AuthRemoteDataSource();


  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      return await authRemoteDataSource.login(request);
    } catch (error) {
      throw Exception('Error in repository during login: $error');
    }
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest request) async {
    try {
      return await authRemoteDataSource.forgotPassword(request);
    } catch (error) {
      throw Exception('Error in repository during forgot password: $error');
    }
  }

  @override
  Future<RegisterUserResponse> registerUser(RegisterUserRequest request) async {
   try{
     return await authRemoteDataSource.registerUser(request);

   }catch(error){
     throw Exception('Error in repository during registration: $error');

   }

  }

  @override
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request) async{
    try{
      return await authRemoteDataSource.resetPassword(request);

    }catch(error){
      throw Exception('Error in repository during reset password: $error');

    }

  }

  @override
  Future<SendOtpEmailResponse> sendOtpEmail(SendOtpEmailRequest request) async {
    try{
      return await authRemoteDataSource.sendOtpEmail(request);

    }catch(error){
      throw Exception('Error in repository during sending otp: $error');

    }
  }

  @override
  Future<SendOtpSmsResponse> sendOtpSms(SendOtpSmsRequest request) async {
    try {
      return await authRemoteDataSource.sendOtpSms(request);
    } catch (error) {
      throw Exception('Error in repository during sending OTP SMS: $error');
    }
  }

  @override
  Future<GoogleSignInResponse> signInWithGoogle(GoogleSignInRequest request) async {
    try {
      return await authRemoteDataSource.signInWithGoogle(request);
    } catch (error) {
      throw Exception('Error in repository during Google sign-in: $error');
    }
  }

  @override
  Future<UpdatePasswordResponse> updatePassword(UpdatePasswordRequest request) async {
    try {
      return await authRemoteDataSource.updatePassword(request);
    } catch (error) {
      throw Exception('Error in repository during password update: $error');
    }
  }

  @override
  Future<bool> logout() async {
    try {
      return await authRemoteDataSource.logout();
    } catch (error) {
      throw Exception('Error in repository during logout: $error');
    }
  }



}