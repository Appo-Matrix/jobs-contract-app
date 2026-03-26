import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../data/models/language/language_model.dart';
import '../../../../data/repositories/language_repository_impl.dart';
import '../../../../domain/repository/language_repository.dart';

class LanguageProvider extends ChangeNotifier {
  final LanguageRepository repository = LanguageRepositoryImpl();

  // ── Loading flags ──────────────────────────────────────────────────────────
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // ── My languages list ──────────────────────────────────────────────────────
  List<LanguageModel> _languages = [];
  List<LanguageModel> get languages => _languages;

  // ── Single language (for fetch by id) ─────────────────────────────────────
  LanguageModel? _language;
  LanguageModel? get language => _language;

  // ── Add language ───────────────────────────────────────────────────────────
  Future<bool> addLanguage(LanguageModel model) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final added = await repository.addLanguage(model);

      // Optimistically add to local list
      _languages.add(added);

      Fluttertoast.showToast(msg: 'Language added successfully');
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ── Fetch language by ID ───────────────────────────────────────────────────
  Future<void> fetchLanguageById(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _language = await repository.getLanguageById(id);
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('fetchLanguageById error: $_errorMessage');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ── Delete language ────────────────────────────────────────────────────────
  Future<bool> deleteLanguage(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await repository.deleteLanguage(id);

      // Optimistically remove from local list
      _languages.removeWhere((l) => l.id == id);

      Fluttertoast.showToast(msg: 'Language deleted successfully');
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ── Update language ────────────────────────────────────────────────────────
  Future<bool> updateLanguage(String id, LanguageModel model) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updated = await repository.updateLanguage(id, model);

      // Replace in local list
      final index = _languages.indexWhere((l) => l.id == id);
      if (index != -1) {
        _languages[index] = updated;
      }

      Fluttertoast.showToast(msg: 'Language updated successfully');
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ── Fetch my languages ─────────────────────────────────────────────────────
  Future<void> fetchMyLanguages() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _languages = await repository.getMyLanguages();
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('fetchMyLanguages error: $_errorMessage');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}