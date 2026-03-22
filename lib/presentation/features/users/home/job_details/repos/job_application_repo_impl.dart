import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../../../../core/constants/api_endpoints.dart';
import '../../../../../../data/data_source/local/AuthPreferences.dart';
import '../models/job_application_model_new.dart';
import '../repos/job_application_repo.dart';

class JobApplicationRepoImpl implements JobApplicationRepo {
  @override
  Future<JobApplicationResponseModelNew> submitJobApplication({
    required String jobId,
    required String coverLetter,
  }) async {
    final url = Uri.parse(ApiPath.baseUrl + ApiPath.submitJobApplication);

    // ── Retrieve token + user from AuthPreferences ────────────────────────
    final token = await AuthPreferences.getToken() ?? '';
    final user  = await AuthPreferences.getUser();

    log('=== SUBMIT JOB APPLICATION ===');
    log('URL        : $url');
    log('User       : ${user?.email ?? "unknown"} (${user?.userType ?? "unknown"})');
    log('Token found: ${token.isNotEmpty ? "YES (${token.substring(0, token.length.clamp(0, 20))}...)" : "NO — token is EMPTY!"}');

    // ── Guard: don't submit if no token ───────────────────────────────────
    if (token.isEmpty) {
      throw Exception('You must be logged in to submit a job application');
    }

    // ── Build request body ────────────────────────────────────────────────
    final body = JobApplicationModelNew(
      jobId: jobId,
      coverLetter: coverLetter,
    ).toJson();

    log('Request body: ${jsonEncode(body)}');

    // ── Make HTTP request ─────────────────────────────────────────────────
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    log('Status code  : ${response.statusCode}');
    log('Response body: ${response.body}');

    // ── Handle response ───────────────────────────────────────────────────
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200 || response.statusCode == 201) {
      return JobApplicationResponseModelNew.fromJson(responseData);
    } else {
      final errorMessage = responseData['message'] ??
          responseData['error'] ??
          responseData['msg'] ??
          'Failed to submit application (${response.statusCode})';
      throw Exception(errorMessage);
    }
  }
}