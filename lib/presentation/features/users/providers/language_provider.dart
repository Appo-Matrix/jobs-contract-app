// lib/presentation/providers/language_provider.dart
import 'package:flutter/material.dart';
import 'package:job_contracts/data/repositories/language_repository_impl.dart';

import '../../../../data/models/language/language_model.dart';
import '../../../../domain/repository/language_repository.dart';


class LanguageProvider extends ChangeNotifier {

  final LanguageRepository repository = LanguageRepositoryImpl();


  bool isLoading = false;
  String? errorMessage;
  LanguageModel? addedLanguage;

  LanguageModel? _language;
  LanguageModel? get language => _language;

  LanguageModel? _updatedLanguage;
  LanguageModel? get updatedLanguage => _updatedLanguage;

  List<LanguageModel> _languages = [];
  List<LanguageModel> get languages => _languages;


  Future<void> addLanguage(LanguageModel model) async {
    isLoading = true;
    notifyListeners();

    try {
      addedLanguage = await repository.addLanguage(model);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchLanguageById(String id) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await repository.getLanguageById(id);
      _language = result;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteLanguage(String id) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await repository.deleteLanguage(id);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateLanguage(String id, LanguageModel model) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await repository.updateLanguage(id, model);
      _updatedLanguage = result;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMyLanguages() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await repository.getMyLanguages();
      _languages = result;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
