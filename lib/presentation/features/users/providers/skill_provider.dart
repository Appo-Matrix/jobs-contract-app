import 'package:flutter/material.dart';
import 'package:job_contracts/data/repositories/skill_repository_impl.dart';

import '../../../../data/models/skills/add_skill_req.dart';
import '../../../../data/models/skills/skill_model.dart';
import '../../../../domain/repository/skill_repository.dart';

class SkillProvider with ChangeNotifier {

  final SkillRepository repository = SkillRepositoryImpl();


  bool _isLoading = false;
  String _errorMessage = '';
  String _successMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get successMessage => _successMessage;

  List<SkillModel> _skills = [];
  List<SkillModel> get skills => _skills;



  Future<void> addSkill(String userId, String name) async {
    _isLoading = true;
    _errorMessage = '';
    _successMessage = '';
    notifyListeners();

    try {
      final request = AddSkillRequest(userId: userId, name: name);
      final response = await repository.addSkill(request);
      _successMessage = response.message;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadAllSkills() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _skills = await repository.fetchAllSkills();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadSkillsByUser(String userId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _skills = await repository.fetchSkillsByUser(userId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteSkill(String skillId) async {
    _isLoading = true;
    _errorMessage = '';
    _successMessage = '';
    notifyListeners();

    try {
      _successMessage = await repository.deleteSkill(skillId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteSkillById(String skillId) async {
    _isLoading = true;
    _errorMessage = '';
    _successMessage = '';
    notifyListeners();

    try {
      final msg = await repository.removeSkillById(skillId);
    } catch (e) {
      _errorMessage = e.toString();

    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
