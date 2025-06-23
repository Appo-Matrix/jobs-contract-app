import 'package:flutter/material.dart';

import '../../../../data/models/user/user_talent_res.dart';
import '../../../../data/repositories/user_repository_impl.dart';
import '../../../../domain/repository/user_repository.dart';

class TalentProvider with ChangeNotifier {
  final UserRepository _userRepository = UserRepositoryImpl();

  List<Talent> talents = [];
  Pagination? pagination;
  bool isLoading = false;
  String? error;

  Future<void> fetchTalents({int page = 1, int limit = 10}) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _userRepository.getTalents(page: page, limit: limit);
      talents = result.data;
      pagination = result.pagination;
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
