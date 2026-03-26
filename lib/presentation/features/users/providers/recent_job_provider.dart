import 'dart:developer';
import 'package:flutter/material.dart';

import '../account_screen/models/recent_job_model.dart';
import '../account_screen/repos/recent_job_repo.dart';
import '../account_screen/repos/recent_job_repo_impl.dart';

class RecentJobProvider extends ChangeNotifier {
  final RecentJobRepo _repo;

  RecentJobProvider({RecentJobRepo? repo})
      : _repo = repo ?? RecentJobRepoImpl();

  // ─── State ───────────────────────────────────────────────────────────────

  List<RecentJobModel> _recentJobs = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _hasFetched = false;

  // ─── Getters ─────────────────────────────────────────────────────────────

  List<RecentJobModel> get recentJobs => _recentJobs;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasFetched => _hasFetched;
  bool get hasJobs => _recentJobs.isNotEmpty;

  /// Returns only the first [count] jobs (useful for home screen previews).
  List<RecentJobModel> getPreviewJobs({int count = 2}) {
    return _recentJobs.take(count).toList();
  }

  // ─── Actions ─────────────────────────────────────────────────────────────

  /// Fetches recent jobs. Skips if already fetched unless [forceRefresh] is true.
  Future<void> fetchRecentJobs({bool forceRefresh = false}) async {
    if (_hasFetched && !forceRefresh) return;

    _setLoading(true);
    _clearError();

    try {
      final response = await _repo.fetchRecentJobs();
      _recentJobs = response.data;
      _hasFetched = true;
      log('✅ RecentJobProvider: loaded ${_recentJobs.length} jobs');
    } catch (e) {
      _errorMessage = _parseError(e);
      log('❌ RecentJobProvider error: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Refreshes jobs regardless of previous fetch state.
  Future<void> refreshRecentJobs() async {
    await fetchRecentJobs(forceRefresh: true);
  }

  // ─── Private Helpers ─────────────────────────────────────────────────────

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }

  String _parseError(Object e) {
    final msg = e.toString();
    if (msg.contains('SocketException') || msg.contains('Failed host lookup')) {
      return 'No internet connection. Please check your network.';
    } else if (msg.contains('TimeoutException')) {
      return 'Request timed out. Please try again.';
    } else if (msg.contains('Unauthorized')) {
      return 'Session expired. Please log in again.';
    }
    // Strip "Exception: " prefix for cleaner UI messages
    return msg.replaceFirst('Exception: ', '');
  }
}