
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../data/models/feedback/feedback_request.dart';
import '../../../../data/models/feedback/feedback_response.dart';
import '../../../../data/models/feedback/user_rating_model.dart';
import '../../../../data/repositories/feedback_repository_impl.dart';
import '../../../../domain/repository/feedback_repository.dart';



class FeedbackProvider with ChangeNotifier {
  final FeedbackRepository repository = FeedbackRepositoryImpl();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  FeedbackResponse? _feedbackResponse;
  FeedbackResponse? get feedbackResponse => _feedbackResponse;

  List<FeedbackResponse> _feedbacks = [];
  List<FeedbackResponse> get feedbacks => _feedbacks;

  FeedbackResponse? _feedback;
  FeedbackResponse? get feedback => _feedback;

  List<FeedbackResponse> _userFeedbacks = [];
  List<FeedbackResponse> get userFeedbacks => _userFeedbacks;

  UserRatingModel? _userRating;
  UserRatingModel? get userRating => _userRating;

  Future<void> submitFeedback(FeedbackRequest request) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _feedbackResponse = await repository.submitFeedback(request);
      Fluttertoast.showToast(
        msg: "Feedback submitted successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(
        msg: _error!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllFeedbacks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _feedbacks = await repository.getAllFeedbacks();
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(msg: _error!, gravity: ToastGravity.BOTTOM);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchFeedbackById(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _feedback = await repository.getFeedbackById(id);
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(
        msg: _error!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserFeedbacks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _userFeedbacks = await repository.getUserFeedbacks();
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(
        msg: _error!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> fetchUserRating(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _userRating = await repository.getUserRating(userId);
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(
        msg: _error!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
