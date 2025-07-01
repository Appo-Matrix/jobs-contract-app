// lib/domain/repository/email_repository.dart

import '../../data/models/email/email_settings_model.dart';

abstract class EmailRepository {

  Future<EmailSettingsModel> updateEmailSettings(EmailSettingsModel data);
}
