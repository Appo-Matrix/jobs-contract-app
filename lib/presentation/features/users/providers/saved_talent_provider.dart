import 'package:flutter/material.dart';
import 'package:job_contracts/data/repositories/talent_repository_impl.dart';

import '../../../../data/models/saved_talents/saved_talent_res.dart';
import '../../../../data/models/saved_talents/toggle_talent_save_req.dart';
import '../../../../domain/repository/talent_repository.dart';

class SavedTalentsProvider with ChangeNotifier {

  final TalentRepository repository = TalentRepositoryImpl();


  bool _isLoading = false;
  String _errorMessage = '';
  List<SavedTalent> _savedTalents = [];

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<SavedTalent> get savedTalents => _savedTalents;

  Future<void> loadSavedTalents() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await repository.getSavedTalents();
      _savedTalents = response.data;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleSaveTalent(String clientId, String talentId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final request = ToggleTalentSaveRequest(clientId: clientId, talentId: talentId);
      await repository.toggleSaveTalent(request);
      await loadSavedTalents(); // Refresh list
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
