import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:job_contracts/data/data_source/remote/bank_account_rds.dart';

import '../../domain/repository/bank_account_repository.dart';
import '../models/payments/bank_account_request_model.dart';
import '../models/payments/bank_account_response_model.dart';
import '../models/payments/create_payment_intent_request_model.dart';
import '../models/payments/create_payment_intent_response_model.dart';
import '../models/payments/payment_method_model.dart';
import '../models/payments/payment_method_request_model.dart';
import '../models/payments/payment_method_response_model.dart';
import '../models/payments/process_payment_request_model.dart';
import '../models/payments/process_payment_response_model.dart';
import '../models/payments/set_default_payment_method_request_model.dart';
import '../models/payments/set_default_payment_method_response_model.dart';
import '../models/payments/verify_payment_method_response_model.dart';
import '../models/payments/web_hook_res.dart';
import '../models/payments/withdraw_req.dart';
import '../models/payments/withdraw_res.dart';



class BankAccountRepositoryImpl implements BankAccountRepository {

  final BankAccountRemoteDataSource remoteDataSource = BankAccountRemoteDataSource();

  @override
  Future<BankAccountResponseModel> addBankAccount(BankAccountRequestModel model) {
    try {
      return remoteDataSource.addBankAccount(model);
    } catch (e){
      throw Exception('Error in repository during adding bank account: $e');

    }
  }

  @override
  Future<PaymentMethodResponseModel> addPaymentMethod(PaymentMethodRequestModel model) {
    try {
      return remoteDataSource.addPaymentMethod(model);
    } catch (e){
      throw Exception('Error in repository during adding payment method: $e');

    }
  }

  @override
  Future<CreatePaymentIntentResponseModel> createPaymentIntent(CreatePaymentIntentRequestModel model) {
    try {
      return remoteDataSource.createPaymentIntent(model);
    } catch (e){
      throw Exception('Error in repository during creating payment method: $e');

    }
  }

  @override
  Future<List<PaymentMethodModel>> getUserPaymentMethods(String userId) {
    try {
      return remoteDataSource.fetchUserPaymentMethods(userId);
    } catch (e){
      throw Exception('Error in repository during getting payment method: $e');
    }
  }


  @override
  Future<ProcessPaymentResponseModel> processPayment(ProcessPaymentRequestModel model) {
    try {
      return remoteDataSource.processPayment(model);
    } catch (e){
      throw Exception('Error in repository during payment process method: $e');
    }
  }

  @override
  Future<SetDefaultPaymentMethodResponseModel> setDefaultPaymentMethod(SetDefaultPaymentMethodRequestModel model) {
    try {
      return remoteDataSource.setDefaultPaymentMethod(model);
    } catch (e){
      throw Exception('Error in repository during setting default payment method: $e');
    }
  }


  @override
  Future<VerifyPaymentMethodResponseModel> verifyPaymentMethod(String paymentMethodId) {
    try {
      return remoteDataSource.verifyPaymentMethod(paymentMethodId);
    } catch (e){
      throw Exception('Error in repository during verification of payment method: $e');

    }
  }

  @override
  Future<WebhookResponseModel> handleStripeWebhook({required String stripeSignature, required Map<String, dynamic> payload}) {
    try {
      return remoteDataSource.handleStripeWebhook(stripeSignature: stripeSignature, payload: payload);
    } catch (e){
      throw Exception('Error in repository during adding stripe webhook: $e');
    }
  }

  @override
  Future<WithdrawResponseModel> withdrawFunds(WithdrawRequestModel model) {
    try {
      return remoteDataSource.withdrawFunds(model);
    } catch (e) {
      throw Exception('Error in repository during withdrawal of funds: $e');

    }
  }
}
