import '../../data/data_source/remote/preferences_rds.dart';
import '../../data/models/preferences/delete_preferences_response_model.dart';
import '../../domain/repository/preferences_repository.dart';
import '../models/preferences/real_estate_preferences_model.dart';
import '../models/preferences/user_preference_user_model.dart';
import '../models/preferences/user_preferences_model.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  final PreferencesRemoteDataSource remoteDataSource = PreferencesRemoteDataSource();

  @override
  Future<DeletePreferencesResponseModel> deleteUserPreferences(String userId) async {
    try {
      return await remoteDataSource.deleteUserPreferences(userId);
    } catch (e) {
      throw Exception('Failed to delete preferences: $e');
    }
  }

  @override
  Future<UserPreferencesModel> getUserPreferences(String userId) async {
    try {
      return await remoteDataSource.getUserPreferences(userId);
    } catch (e) {
      throw Exception('Failed to fetch preferences: $e');
    }
  }

  @override
  Future<List<PreferenceUserModel>> searchUsersByJobPreference(String job) async {
    try {
      return await remoteDataSource.searchUsersByJobPreference(job);
    } catch (e) {
      throw Exception('Failed to search users by job preference: $e');
    }
  }

  @override
  Future<RealEstatePreferencesModel> updatePreferences(RealEstatePreferencesModel model) async {
    try {
      return await remoteDataSource.updatePreferences(model);
    } catch (e) {
      throw Exception('Failed to update preference: $e');

    }
  }
}
