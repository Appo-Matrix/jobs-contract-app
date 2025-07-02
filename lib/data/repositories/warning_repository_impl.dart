import '../../domain/repository/warning_repository.dart';
import '../data_source/remote/warning_rds.dart';
import '../models/warnings/delete_warning_res.dart';
import '../models/warnings/issue_warning_req.dart';
import '../models/warnings/issue_warning_res.dart';
import '../models/warnings/user_warning.dart';
import '../models/warnings/warning_model.dart';

class WarningRepositoryImpl implements WarningRepository {
  final WarningRemoteDataSource rds = WarningRemoteDataSource();


  @override
  Future<IssueWarningResponse> issueWarning(IssueWarningRequest request) async {
    try {
      return await rds.issueWarning(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DeleteWarningResponse> deleteWarning(String id) async {
    try {
      return await rds.deleteWarning(id);
    } catch (e) {
      rethrow;
    }
  }


  @override
  Future<List<WarningModel>> getMyWarnings() async {
    try {
      return await rds.getMyWarnings();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserWarning>> getWarningsByUserId(String userId) async {
    try {
      return await rds.getWarningsByUserId(userId);
    } catch (e) {
      rethrow;
    }
  }
}
