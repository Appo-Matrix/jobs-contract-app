import '../../data/models/warnings/delete_warning_res.dart';
import '../../data/models/warnings/issue_warning_req.dart';
import '../../data/models/warnings/issue_warning_res.dart';
import '../../data/models/warnings/user_warning.dart';
import '../../data/models/warnings/warning_model.dart';

abstract class WarningRepository {

  Future<IssueWarningResponse> issueWarning(IssueWarningRequest request);

  Future<DeleteWarningResponse> deleteWarning(String id);

  Future<List<WarningModel>> getMyWarnings();

  Future<List<UserWarning>> getWarningsByUserId(String userId);



}
