import 'package:job_contracts/data/data_sources/remote/auth_rds.dart';

import '../../domain/repository/auth_repository.dart';
import '../models/auth/login_req.dart';
import '../models/auth/login_res.dart';

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
}