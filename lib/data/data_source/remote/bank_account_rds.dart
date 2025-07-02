

import 'package:job_contracts/core/constants/api_endpoints.dart';
import 'package:job_contracts/core/network/api_client.dart';

import '../../models/payments/bank_account_request_model.dart';
import '../../models/payments/bank_account_response_model.dart';
import '../../models/payments/create_payment_intent_request_model.dart';
import '../../models/payments/create_payment_intent_response_model.dart';
import '../../models/payments/payment_method_model.dart';
import '../../models/payments/payment_method_request_model.dart';
import '../../models/payments/payment_method_response_model.dart';
import '../../models/payments/process_payment_request_model.dart';
import '../../models/payments/process_payment_response_model.dart';
import '../../models/payments/set_default_payment_method_request_model.dart';
import '../../models/payments/set_default_payment_method_response_model.dart';
import '../../models/payments/verify_payment_method_response_model.dart';
import '../../models/payments/web_hook_res.dart';
import '../../models/payments/withdraw_req.dart';
import '../../models/payments/withdraw_res.dart';

class BankAccountRemoteDataSource {
  final ApiClient apiClient= ApiClient(ApiPath.baseUrl);


  Future<BankAccountResponseModel> addBankAccount(BankAccountRequestModel model) async {
    final response = await apiClient.post(
      endpoint: ApiPath.addBankAccount,
      data: model.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return BankAccountResponseModel.fromJson(response.data['bankAccount']);
      case 400:
      case 404:
      case 500:
        throw Exception(response.data['error'] ?? 'Something went wrong');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<PaymentMethodResponseModel> addPaymentMethod(
      PaymentMethodRequestModel model) async {
    final response = await apiClient.post(
      endpoint: ApiPath.addPaymentMethod,
      data: model.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return PaymentMethodResponseModel.fromJson(response.data);
      case 400:
      case 404:
        throw Exception(response.data['error']);
      case 500:
        throw Exception(response.data['error'] ?? 'Internal Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<CreatePaymentIntentResponseModel> createPaymentIntent(
      CreatePaymentIntentRequestModel model,
      ) async {
    final response = await apiClient.post(
      endpoint: ApiPath.createPaymentIntent,
      data: model.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return CreatePaymentIntentResponseModel.fromJson(response.data);
      case 400:
        throw Exception(response.data['error'] ?? 'Invalid request data');
      case 500:
        throw Exception(response.data['error'] ?? 'Stripe Payment Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<List<PaymentMethodModel>> fetchUserPaymentMethods(String userId) async {
    final response = await apiClient.get(
      ApiPath.getUserPaymentMethods(userId),
    );

    switch (response.statusCode) {
      case 200:
        final List data = response.data['paymentMethods'] ?? [];
        return data.map((e) => PaymentMethodModel.fromJson(e)).toList();
      case 400:
      case 404:
        throw Exception(response.data['error'] ?? 'Unable to retrieve payment methods');
      case 500:
        throw Exception('Internal Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<ProcessPaymentResponseModel> processPayment(ProcessPaymentRequestModel model) async {
    final response = await apiClient.post(
      endpoint: ApiPath.processPayment,
      data: model.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return ProcessPaymentResponseModel.fromJson(response.data);
      case 400:
      case 404:
        throw Exception(response.data['error'] ?? 'Payment failed or user not found');
      case 500:
        throw Exception(response.data['error'] ?? 'Internal Server Error');
      default:
        throw Exception('Unexpected status code: ${response.statusCode}');
    }
  }


  Future<SetDefaultPaymentMethodResponseModel> setDefaultPaymentMethod(
      SetDefaultPaymentMethodRequestModel model,
      ) async {
    final response = await apiClient.post(
      endpoint: ApiPath.setDefaultPaymentMethod,
      data: model.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return SetDefaultPaymentMethodResponseModel.fromJson(response.data);
      case 400:
      case 404:
        throw Exception(response.data['error'] ?? 'Invalid request or user not found');
      case 500:
        throw Exception(response.data['error'] ?? 'Internal Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<VerifyPaymentMethodResponseModel> verifyPaymentMethod(String paymentMethodId) async {
    final response = await apiClient.get(
      ApiPath.verifyPaymentMethod(paymentMethodId),
    );

    switch (response.statusCode) {
      case 200:
        return VerifyPaymentMethodResponseModel.fromJson(response.data);
      case 400:
      case 404:
        throw Exception(response.data['error'] ?? 'Invalid or not found');
      case 500:
        throw Exception(response.data['error'] ?? 'Internal Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<WebhookResponseModel> handleStripeWebhook({
    required String stripeSignature,
    required Map<String, dynamic> payload,
  }) async {
    final response = await apiClient.post(
      endpoint: ApiPath.stripeWebhook,
      data: payload,
    );

    switch (response.statusCode) {
      case 200:
        return WebhookResponseModel.fromJson(response.data);
      case 400:
        throw Exception(response.data['error'] ?? 'Webhook error');
      case 500:
        throw Exception(response.data['error'] ?? 'Internal Server Error');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<WithdrawResponseModel> withdrawFunds(WithdrawRequestModel model) async {
    final response = await apiClient.post(
      endpoint: ApiPath.withdrawFunds,
      data: model.toJson(),
    );

    switch (response.statusCode) {
      case 200:
        return WithdrawResponseModel.fromJson(response.data);
      case 400:
        throw Exception(response.data['error'] ?? 'Withdrawal failed');
      case 404:
        throw Exception(response.data['error'] ?? 'User not found or not connected to Stripe');
      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }
}
