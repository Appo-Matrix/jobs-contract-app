 import '../../data/models/auth/login_req.dart';
import '../../data/models/auth/login_res.dart';

abstract class AuthRepository {

  Future<LoginResponse> login(LoginRequest request);

 }