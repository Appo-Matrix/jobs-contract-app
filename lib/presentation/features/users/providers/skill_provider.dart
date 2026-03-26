// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import '../../../../data/models/skills/add_skill_req.dart';
// import '../../../../data/models/skills/skill_model.dart';
// import '../../../../data/repositories/skill_repository_impl.dart';
// import '../../../../domain/repository/skill_repository.dart';
//
// class SkillProvider with ChangeNotifier {
//   final SkillRepository repository = SkillRepositoryImpl();
//
//   // ── Loading flags (separate so saves don't hide the list) ─────────────────
//   bool _isLoadingAll = false;
//   bool _isLoadingMine = false;
//   bool _isLoadingUser = false;
//
//   bool get isLoadingAll => _isLoadingAll;
//   bool get isLoadingMine => _isLoadingMine;
//
//   // Combined flag for callers that just need "any loading"
//   bool get isLoading => _isLoadingAll || _isLoadingMine || _isLoadingUser;
//
//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;
//
//   // ── All skills (/skills/all) — strings only, id is null ───────────────────
//   List<SkillModel> _skills = [];
//   List<SkillModel> get skills => _skills;
//
//   // ── My skills (/skills/me) — full objects with id ─────────────────────────
//   List<SkillModel> _mySkills = [];
//   List<SkillModel> get mySkills => _mySkills;
//
//   // ── User skills (/skills/user/:id) ────────────────────────────────────────
//   List<SkillModel> _userSkills = [];
//   List<SkillModel> get userSkills => _userSkills;
//
//   // ── Load all skills ───────────────────────────────────────────────────────
//   Future<void> loadAllSkills() async {
//     _isLoadingAll = true;
//     _errorMessage = null;
//     notifyListeners();
//
//     try {
//       final response = await repository.fetchAllSkills();
//
//       // Deduplicate by name (case-insensitive) — API returns duplicates
//       final seen = <String>{};
//       _skills = response
//           .where((s) => seen.add(s.name.toLowerCase()))
//           .toList();
//     } catch (e) {
//       _errorMessage = e.toString();
//       debugPrint('loadAllSkills error: $_errorMessage');
//     } finally {
//       _isLoadingAll = false;
//       notifyListeners();
//     }
//   }
//
//   // ── Load my skills ────────────────────────────────────────────────────────
//   Future<void> loadMySkills() async {
//     _isLoadingMine = true;
//     _errorMessage = null;
//     notifyListeners();
//
//     try {
//       _mySkills = await repository.fetchMySkills();
//     } catch (e) {
//       _errorMessage = e.toString();
//       debugPrint('loadMySkills error: $_errorMessage');
//     } finally {
//       _isLoadingMine = false;
//       notifyListeners();
//     }
//   }
//
//   // ── Load skills by user ───────────────────────────────────────────────────
//   Future<void> loadSkillsByUser(String userId) async {
//     _isLoadingUser = true;
//     _errorMessage = null;
//     notifyListeners();
//
//     try {
//       _userSkills = await repository.fetchSkillsByUser(userId);
//     } catch (e) {
//       _errorMessage = e.toString();
//       debugPrint('loadSkillsByUser error: $_errorMessage');
//     } finally {
//       _isLoadingUser = false;
//       notifyListeners();
//     }
//   }
//
//   // ── Add skill ─────────────────────────────────────────────────────────────
//   Future<void> addSkill(String name) async {
//     _errorMessage = null;
//
//     try {
//       final request = AddSkillRequest(name: name);
//       final response = await repository.addSkill(request);
//
//       // Optimistically add to mySkills
//       if (response.data != null) {
//         _mySkills.add(SkillModel(
//           id: response.data!.id,
//           userId: response.data!.userId,
//           name: response.data!.name,
//         ));
//         notifyListeners();
//       }
//
//       Fluttertoast.showToast(msg: response.message);
//     } catch (e) {
//       _errorMessage = e.toString();
//       Fluttertoast.showToast(msg: _errorMessage!);
//       rethrow; // let caller handle failure (e.g. stop save loop)
//     }
//   }
//
//   // ── Delete skill ──────────────────────────────────────────────────────────
//   Future<void> deleteSkill(String skillId) async {
//     _errorMessage = null;
//
//     try {
//       await repository.deleteSkill(skillId);
//       // Optimistically remove from mySkills
//       _mySkills.removeWhere((s) => s.id == skillId);
//       notifyListeners();
//       Fluttertoast.showToast(msg: 'Skill deleted successfully');
//     } catch (e) {
//       _errorMessage = e.toString();
//       Fluttertoast.showToast(msg: _errorMessage!);
//       rethrow;
//     }
//   }
// }



import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../data/models/skills/add_skill_req.dart';
import '../../../../data/models/skills/skill_model.dart';
import '../../../../data/repositories/skill_repository_impl.dart';
import '../../../../domain/repository/skill_repository.dart';

class SkillProvider with ChangeNotifier {
  final SkillRepository repository = SkillRepositoryImpl();

  // ── Loading flags ──────────────────────────────────────────────────────────
  bool _isLoadingAll = false;
  bool _isLoadingMine = false;
  bool _isLoadingUser = false;

  bool get isLoadingAll => _isLoadingAll;
  bool get isLoadingMine => _isLoadingMine;
  bool get isLoading => _isLoadingAll || _isLoadingMine || _isLoadingUser;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // ── Full list (all 321, deduplicated, kept in memory) ─────────────────────
  List<SkillModel> _allSkillsFull = [];

  // ── Visible slice shown in UI (grows as user scrolls) ─────────────────────
  List<SkillModel> _visibleSkills = [];
  List<SkillModel> get visibleSkills => _visibleSkills;

  static const int _pageSize = 20;
  int _currentPage = 0;
  bool _hasMore = false;
  bool get hasMore => _hasMore;

  // ── My skills (/skills/me) full objects with _id ──────────────────────────
  List<SkillModel> _mySkills = [];
  List<SkillModel> get mySkills => _mySkills;

  // ── User skills (/skills/user/:id) ────────────────────────────────────────
  List<SkillModel> _userSkills = [];
  List<SkillModel> get userSkills => _userSkills;

  // ── Load all skills once on sheet open ────────────────────────────────────
  Future<void> loadAllSkills() async {
    _isLoadingAll = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await repository.fetchAllSkills();

      // Deduplicate by name (case-insensitive) — API returns duplicates
      final seen = <String>{};
      _allSkillsFull = response
          .where((s) => seen.add(s.name.toLowerCase()))
          .toList();

      // Reset and load first page
      _currentPage = 0;
      _visibleSkills = [];
      _appendNextPage(_allSkillsFull);
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('loadAllSkills error: $_errorMessage');
    } finally {
      _isLoadingAll = false;
      notifyListeners();
    }
  }

  // ── Append next page from a source list ───────────────────────────────────
  void _appendNextPage(List<SkillModel> source) {
    final start = _currentPage * _pageSize;
    if (start >= source.length) {
      _hasMore = false;
      return;
    }
    final end = (start + _pageSize).clamp(0, source.length);
    _visibleSkills.addAll(source.sublist(start, end));
    _currentPage++;
    _hasMore = end < source.length;
  }

  // ── Called by scroll listener to load more ────────────────────────────────
  void loadMoreSkills({String query = ''}) {
    if (!_hasMore) return;
    _appendNextPage(_getFilteredSource(query));
    notifyListeners();
  }

  // ── Called on search — resets visible list and re-paginates ──────────────
  void filterSkills(String query) {
    _currentPage = 0;
    _visibleSkills = [];
    _appendNextPage(_getFilteredSource(query));
    notifyListeners();
  }

  List<SkillModel> _getFilteredSource(String query) {
    if (query.isEmpty) return _allSkillsFull;
    return _allSkillsFull
        .where((s) => s.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // ── Check if a name already exists in the full list ───────────────────────
  bool skillExistsByName(String name) {
    return _allSkillsFull
        .any((s) => s.name.toLowerCase() == name.toLowerCase());
  }

  // ── Load my skills (/skills/me) ───────────────────────────────────────────
  Future<void> loadMySkills() async {
    _isLoadingMine = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _mySkills = await repository.fetchMySkills();
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('loadMySkills error: $_errorMessage');
    } finally {
      _isLoadingMine = false;
      notifyListeners();
    }
  }

  // ── Load skills by user ───────────────────────────────────────────────────
  Future<void> loadSkillsByUser(String userId) async {
    _isLoadingUser = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _userSkills = await repository.fetchSkillsByUser(userId);
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('loadSkillsByUser error: $_errorMessage');
    } finally {
      _isLoadingUser = false;
      notifyListeners();
    }
  }

  // ── Add skill ─────────────────────────────────────────────────────────────
  Future<void> addSkill(String name) async {
    _errorMessage = null;

    try {
      final request = AddSkillRequest(name: name);
      final response = await repository.addSkill(request);

      if (response.data != null) {
        // Add to mySkills (full object with id)
        _mySkills.add(SkillModel(
          id: response.data!.id,
          userId: response.data!.userId,
          name: response.data!.name,
        ));

        // Also insert into full list so it shows in search immediately
        _allSkillsFull.add(SkillModel(name: response.data!.name));

        notifyListeners();
      }

      Fluttertoast.showToast(msg: response.message);
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
      rethrow;
    }
  }

  // ── Delete skill ──────────────────────────────────────────────────────────
  Future<void> deleteSkill(String skillId) async {
    _errorMessage = null;

    try {
      await repository.deleteSkill(skillId);
      _mySkills.removeWhere((s) => s.id == skillId);
      notifyListeners();
      Fluttertoast.showToast(msg: 'Skill deleted successfully');
    } catch (e) {
      _errorMessage = e.toString();
      Fluttertoast.showToast(msg: _errorMessage!);
      rethrow;
    }
  }


  int get totalSkillCount => _allSkillsFull.length; // ← add this
}