import 'package:flutter/foundation.dart';

import '../../data/data_source/remote/language_rds.dart';
import '../../data/models/language/language_model.dart';
import '../../domain/repository/language_repository.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final LanguageRemoteDataSource remoteDataSource = LanguageRemoteDataSource();

  @override
  Future<LanguageModel> addLanguage(LanguageModel model) async {
    try {
      debugPrint('addLanguage → ${model.toJson()}');
      return await remoteDataSource.addLanguage(model);
    } catch (e, st) {
      debugPrint('addLanguage error: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<LanguageModel> getLanguageById(String id) async {
    try {
      debugPrint('getLanguageById → $id');
      return await remoteDataSource.getLanguageById(id);
    } catch (e, st) {
      debugPrint('getLanguageById error: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<void> deleteLanguage(String id) async {
    try {
      debugPrint('deleteLanguage → $id');
      return await remoteDataSource.deleteLanguage(id);
    } catch (e, st) {
      debugPrint('deleteLanguage error: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<LanguageModel> updateLanguage(String id, LanguageModel model) async {
    try {
      debugPrint('updateLanguage → $id ${model.toJson()}');
      return await remoteDataSource.updateLanguage(id, model);
    } catch (e, st) {
      debugPrint('updateLanguage error: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<List<LanguageModel>> getMyLanguages() async {
    try {
      debugPrint('getMyLanguages → start');
      return await remoteDataSource.getMyLanguages();
    } catch (e, st) {
      debugPrint('getMyLanguages error: $e\n$st');
      rethrow;
    }
  }
}