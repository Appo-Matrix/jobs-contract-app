import 'package:job_contracts/core/constants/api_endpoints.dart';
import 'package:job_contracts/core/network/api_client.dart';

import '../../models/subscription/cancel_subscription_req.dart';
import '../../models/subscription/cancel_subscription_res.dart';
import '../../models/subscription/start_free_trial_res.dart';
import '../../models/subscription/upgrade_subscription_req.dart';
import '../../models/subscription/upgrade_subscription_res.dart';

class SubscriptionRemoteDataSource {
  final ApiClient apiClient = ApiClient(ApiPath.baseUrl);


  Future<CancelSubscriptionResponse> cancelUserSubscription(CancelSubscriptionRequest request) async {
    final res = await apiClient.post(endpoint: ApiPath.cancelSubscription, data: request.toJson(),);

    switch (res.statusCode) {
      case 200:
        return CancelSubscriptionResponse.fromJson(res.data);
      case 400:
      case 404:
        throw Exception(res.data['message']);
      case 500:
        throw Exception(res.data['error'] ?? 'Internal Server Error');
      default:
        throw Exception('Unexpected error: ${res.statusCode}');
    }
  }

  Future<StartFreeTrialResponse> startFreeTrial() async {
    final res = await apiClient.post(
      endpoint: ApiPath.startFreeTrial,
    );

    switch (res.statusCode) {
      case 200:
        return StartFreeTrialResponse.fromJson(res.data);
      case 401:
        throw Exception(res.data['message'] ?? 'Unauthorized');
      case 500:
        throw Exception(res.data['error'] ?? 'Internal Server Error');
      default:
        throw Exception('Unexpected error: ${res.statusCode}');
    }
  }


  Future<UpgradeSubscriptionResponse> upgradeSubscription(UpgradeSubscriptionRequest request) async {
    final response = await apiClient.post(
      endpoint: ApiPath.upgradeSubscription,
      data: request.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return UpgradeSubscriptionResponse.fromJson(response.data);
      case 400:
        throw Exception(response.data['message'] ?? 'Bad Request');
      case 500:
        throw Exception(response.data['error'] ?? 'Internal Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

}
