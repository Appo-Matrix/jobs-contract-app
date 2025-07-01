

import '../../data/models/feedback/feedback_request.dart';
import '../../data/models/feedback/feedback_response.dart';
import '../../data/models/feedback/user_rating_model.dart';

abstract class FeedbackRepository {

  Future<FeedbackResponse> submitFeedback(FeedbackRequest feedback);

  Future<List<FeedbackResponse>> getAllFeedbacks();

  Future<FeedbackResponse> getFeedbackById(String id);

  Future<List<FeedbackResponse>> getUserFeedbacks();

  Future<UserRatingModel> getUserRating(String userId);






}
