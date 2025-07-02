import '../../data/models/subscription/cancel_subscription_req.dart';
import '../../data/models/subscription/cancel_subscription_res.dart';
import '../../data/models/subscription/start_free_trial_res.dart';
import '../../data/models/subscription/upgrade_subscription_req.dart';
import '../../data/models/subscription/upgrade_subscription_res.dart';

abstract class SubscriptionRepository {

  Future<CancelSubscriptionResponse> cancelSubscription(CancelSubscriptionRequest request);

  Future<StartFreeTrialResponse> startFreeTrial();

  Future<UpgradeSubscriptionResponse> upgradeSubscription(UpgradeSubscriptionRequest request);



}
