import 'package:flutter/material.dart';
import 'package:job_contracts/data/repositories/experience_repository_impl.dart';

import '../../../../data/models/experience/experience_req.dart';
import '../../../../data/models/experience/experience_res.dart';
import '../../../../data/models/experience/work_experience.dart';
import '../../../../domain/repository/experience_repository.dart';

class ExperienceProvider with ChangeNotifier {
  final ExperienceRepository repository = ExperienceRepositoryImpl();

  bool isLoading = false;
  String? error;
  ExperienceResponse? addedExperience;

  List<WorkExperience> experiences = [];

  WorkExperience? experience;

  String? deletionMessage;
  Map<String, dynamic>? updatedExperience;





  Future<void> createExperience(ExperienceRequest request) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      addedExperience = await repository.addExperience(request);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<void> loadExperiences() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      experiences = await repository.getUserExperiences();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadExperience(String id) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      experience = await repository.getExperienceById(id);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteExperience(String id) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      deletionMessage = await repository.deleteExperienceById(id);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateExperience(String id, Map<String, dynamic> data) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      updatedExperience = await repository.updateExperience(id, data);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
