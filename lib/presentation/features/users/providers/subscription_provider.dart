import 'package:flutter/material.dart';
import 'package:job_contracts/data/repositories/subscription_repo_impl.dart';

import '../../../../data/models/subscription/cancel_subscription_req.dart';
import '../../../../data/models/subscription/cancel_subscription_res.dart';
import '../../../../data/models/subscription/start_free_trial_res.dart';
import '../../../../data/models/subscription/upgrade_subscription_req.dart';
import '../../../../data/models/subscription/upgrade_subscription_res.dart';
import '../../../../domain/repository/subscription_repository.dart';

class SubscriptionProvider with ChangeNotifier {

  final SubscriptionRepository repository = SubscriptionRepositoryImpl();


  bool _isLoading = false;
  String? _error;
  CancelSubscriptionResponse? _response;

  bool get isLoading => _isLoading;
  String? get error => _error;
  CancelSubscriptionResponse? get response => _response;

  StartFreeTrialResponse? _freeTrialResponse;
  StartFreeTrialResponse? get freeTrialResponse => _freeTrialResponse;

  UpgradeSubscriptionResponse? _upgradeSubscriptionResponse;
  UpgradeSubscriptionResponse? get upgradeSubscriptionResponse => _upgradeSubscriptionResponse;



  Future<void> cancelSubscription(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final req = CancelSubscriptionRequest(userId: userId);
      _response = await repository.cancelSubscription(req);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> startFreeTrial() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _freeTrialResponse = await repository.startFreeTrial();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> upgradeSubscription(UpgradeSubscriptionRequest request) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _upgradeSubscriptionResponse = await repository.upgradeSubscription(request);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
