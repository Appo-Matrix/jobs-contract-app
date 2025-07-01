import '../../data/models/language/language_model.dart';

abstract class LanguageRepository {

  Future<LanguageModel> addLanguage(LanguageModel model);

  Future<LanguageModel> getLanguageById(String id);

  Future<void> deleteLanguage(String id);

  Future<LanguageModel> updateLanguage(String id, LanguageModel model);

  Future<List<LanguageModel>> getMyLanguages();


}
