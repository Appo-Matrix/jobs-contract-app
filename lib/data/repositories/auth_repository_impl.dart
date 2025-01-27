import 'package:job_contracts/data/data_sources/remote/auth_rds.dart';

import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{

  // Added remote data source to auth repo impl
  final AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();

}