
import '../../../domain/repository/email_repository.dart';
import '../data_source/remote/email_rds.dart';
import '../models/email/email_settings_model.dart';

class EmailRepositoryImpl implements EmailRepository {
  final EmailRemoteDataSource remoteDataSource = EmailRemoteDataSource();


  @override
  Future<EmailSettingsModel> updateEmailSettings(EmailSettingsModel data) async {
    try {
      return await remoteDataSource.updateEmailSettings(data);
    } catch (error) {
      throw Exception('Error updating email settings: $error');
    }
  }
}
