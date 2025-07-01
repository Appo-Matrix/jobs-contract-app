import '../../data/models/preferences/delete_preferences_response_model.dart';
import '../../data/models/preferences/real_estate_preferences_model.dart';
import '../../data/models/preferences/user_preference_user_model.dart';
import '../../data/models/preferences/user_preferences_model.dart';

abstract class PreferencesRepository {

  Future<DeletePreferencesResponseModel> deleteUserPreferences(String userId);

  Future<UserPreferencesModel> getUserPreferences(String userId);

  Future<List<PreferenceUserModel>> searchUsersByJobPreference(String job);

  Future<RealEstatePreferencesModel> updatePreferences(RealEstatePreferencesModel model);


}
