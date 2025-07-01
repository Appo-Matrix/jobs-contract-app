

import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/feedback/feedback_request.dart';
import '../../models/feedback/feedback_response.dart';
import '../../models/feedback/user_rating_model.dart';

class FeedbackRemoteDataSource {

  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);


  Future<FeedbackResponse> submitFeedback(FeedbackRequest feedback) async {
    final response = await apiClient.post(
      endpoint: ApiPath.submitFeedback,
      data: feedback.toJson(),
    );

    if (response.statusCode == 201) {
      return FeedbackResponse.fromJson(response.data['data']);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw Exception(response.data['message']);
    } else {
      throw Exception(response.data['error'] ?? 'Unexpected error');
    }
  }

  Future<List<FeedbackResponse>> getAllFeedbacks() async {
    final response = await apiClient.get(ApiPath.getAllFeedbacks);

    if (response.statusCode == 200) {
      final List data = response.data['data'];
      return data.map((json) => FeedbackResponse.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw Exception(response.data['message']);
    } else {
      throw Exception(response.data['error'] ?? 'Unexpected error');
    }
  }

  Future<FeedbackResponse> getFeedbackById(String id) async {
    final response = await apiClient.get("${ApiPath.getFeedbackById}/$id");

    if (response.statusCode == 200) {
      return FeedbackResponse.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message'] ?? 'Failed to fetch feedback');
    }
  }

  Future<List<FeedbackResponse>> getUserFeedbacks() async {
    final response = await apiClient.get(ApiPath.getUserFeedbacks);

    if (response.statusCode == 200) {
      return (response.data['data'] as List)
          .map((json) => FeedbackResponse.fromJson(json))
          .toList();
    } else {
      throw Exception(response.data['message'] ?? 'Failed to fetch user feedbacks');
    }
  }

  Future<UserRatingModel> getUserRating(String userId) async {
    final response = await apiClient.get(ApiPath.getUserRating(userId));

    if (response.statusCode == 200) {
      return UserRatingModel.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message'] ?? 'Failed to get user rating');
    }
  }
}
