import 'package:flutter/material.dart';

import '../../../../data/models/user/user_hired_talent_res.dart';
import '../../../../data/repositories/user_repository_impl.dart';
import '../../../../domain/repository/user_repository.dart';

class HiredTalentProvider with ChangeNotifier {
  final UserRepository _userRepository = UserRepositoryImpl();

  List<HiredTalent> talents = [];
  HiredTalentPagination? pagination;
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchHiredTalents({int page = 1, int limit = 10}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _userRepository.getHiredTalents(page: page, limit: limit);
      talents = response.data;
      pagination = response.pagination;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
