// lib/data/repositories/language_repository_impl.dart
import '../../data/data_source/remote/language_rds.dart';
import '../../data/models/language/language_model.dart';
import '../../domain/repository/language_repository.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final LanguageRemoteDataSource remoteDataSource = LanguageRemoteDataSource();

  @override
  Future<LanguageModel> addLanguage(LanguageModel model) async {
    try {
      return await remoteDataSource.addLanguage(model);
    } catch (e){
      throw Exception('Error adding language : $e');

    }
  }

  @override
  Future<LanguageModel> getLanguageById(String id) async {
    try {
      return await remoteDataSource.getLanguageById(id);
    } catch (e){
      throw Exception('Error getting language : $e');
    }
  }


  @override
  Future<void> deleteLanguage(String id) async {
    try {
    return await remoteDataSource.deleteLanguage(id);
    } catch (e){
      throw Exception('Error deleting language : $e');
    }
  }


  @override
  Future<LanguageModel> updateLanguage(String id, LanguageModel model) async {
    try {
      return await remoteDataSource.updateLanguage(id, model);
    } catch (e) {
      throw Exception('Error updating language: $e');
    }
  }

  @override
  Future<List<LanguageModel>> getMyLanguages() async {
    try {
      return await remoteDataSource.getMyLanguages();
    } catch (e) {
      throw Exception('Error fetching languages: $e');
    }
  }
}
