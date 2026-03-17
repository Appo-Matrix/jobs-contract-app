
import '../../domain/repository/subscription_repository.dart';
import '../data_source/remote/subscription_rds.dart';
import '../models/subscription/cancel_subscription_req.dart';
import '../models/subscription/cancel_subscription_res.dart';
import '../models/subscription/start_free_trial_res.dart';
import '../models/subscription/upgrade_subscription_req.dart';
import '../models/subscription/upgrade_subscription_res.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionRemoteDataSource remoteDataSource = SubscriptionRemoteDataSource();


  @override
  Future<CancelSubscriptionResponse> cancelSubscription(
      CancelSubscriptionRequest request) async {
    try {
      return await remoteDataSource.cancelUserSubscription(request);
    } catch (e) {
      rethrow;
    }
  }


  @override
  Future<StartFreeTrialResponse> startFreeTrial() async {
    try {
      return await remoteDataSource.startFreeTrial();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UpgradeSubscriptionResponse> upgradeSubscription(UpgradeSubscriptionRequest request) async {
    try {
      return await remoteDataSource.upgradeSubscription(request);
    } catch (e) {
      rethrow;
    }
  }
}
