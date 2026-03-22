import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:job_contract_app/core/constants/api_endpoints.dart';
import '../../../../../data/data_source/local/AuthPreferences.dart';
import '../models/recent_job_model.dart';
import 'recent_job_repo.dart';

class RecentJobRepoImpl implements RecentJobRepo {
  @override
  Future<RecentJobResponse> fetchRecentJobs() async {
    try {
      // ── Retrieve token + user from AuthPreferences ──────────────────────
      final token = await AuthPreferences.getToken();
      final user  = await AuthPreferences.getUser();

      if (token == null || token.isEmpty) {
        throw Exception('Authentication token not found. Please log in again.');
      }

      final uri = Uri.parse('${ApiPath.baseUrl}${ApiPath.getAllJob}');

      log('🌐 Fetching recent jobs from: $uri');
      log('👤 User: ${user?.email ?? "unknown"} (${user?.userType ?? "unknown"})');

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      log('📥 Status: ${response.statusCode}');
      log('📥 Body  : ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final recentJobResponse = RecentJobResponse.fromJson(jsonData);
        log('✅ Fetched ${recentJobResponse.data.length} recent jobs');
        return recentJobResponse;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized. Please log in again.');
      } else if (response.statusCode == 404) {
        throw Exception('Jobs endpoint not found.');
      } else {
        final errorBody = json.decode(response.body);
        final message = errorBody['message'] ?? 'Failed to fetch recent jobs';
        throw Exception(message);
      }
    } on FormatException catch (e) {
      log('❌ JSON Parse Error: $e');
      throw Exception('Invalid response format from server.');
    } catch (e) {
      log('❌ Error fetching recent jobs: $e');
      rethrow;
    }
  }
}