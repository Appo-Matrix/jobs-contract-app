 import '../../data/models/auth/foget_pass_res.dart';
import '../../data/models/auth/forget_pass_req.dart';
import '../../data/models/auth/login_req.dart';
import '../../data/models/auth/login_res.dart';

abstract class AuthRepository {

  Future<LoginResponse> login(LoginRequest request);

  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest request);


}