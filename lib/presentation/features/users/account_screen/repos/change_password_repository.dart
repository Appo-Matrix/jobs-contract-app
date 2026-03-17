
import '../models/change_password_model.dart';

abstract class ChangePasswordRepository {
  Future<ChangePasswordResponseModel> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}