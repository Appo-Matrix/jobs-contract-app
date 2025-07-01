

import 'package:job_contracts/data/data_source/remote/feedback_rds.dart';

import '../../../domain/repository/feedback_repository.dart';
import '../models/feedback/feedback_request.dart';
import '../models/feedback/feedback_response.dart';
import '../models/feedback/user_rating_model.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  final FeedbackRemoteDataSource remoteDataSource= FeedbackRemoteDataSource();


  @override
  Future<FeedbackResponse> submitFeedback(FeedbackRequest feedback) async {
    try {
      return await remoteDataSource.submitFeedback(feedback);
    } catch (error) {
      throw Exception('Failed to submit feedback: $error');
    }
  }

  @override
  Future<List<FeedbackResponse>> getAllFeedbacks() async {
    try {
      return await remoteDataSource.getAllFeedbacks();
    } catch (error) {
      throw Exception('Error fetching feedbacks: $error');
    }
  }

  @override
  Future<FeedbackResponse> getFeedbackById(String id) async {
    try {
      return await remoteDataSource.getFeedbackById(id);
    } catch (e) {
      throw Exception('Failed to retrieve feedback: $e');
    }
  }

  @override
  Future<List<FeedbackResponse>> getUserFeedbacks() async {
    try {
      return await remoteDataSource.getUserFeedbacks();
    } catch (e) {
      throw Exception('Error fetching user feedbacks: $e');
    }
  }

  @override
  Future<UserRatingModel> getUserRating(String userId) async {
    try {
      return await remoteDataSource.getUserRating(userId);
    } catch (e) {
      throw Exception('Error fetching user rating: $e');
    }
  }
}
