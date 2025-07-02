import 'package:flutter/foundation.dart';
import 'package:job_contracts/data/repositories/bank_account_repository_impl.dart';
import 'package:job_contracts/domain/repository/bank_account_repository.dart';

import '../../../../data/models/payments/bank_account_request_model.dart';
import '../../../../data/models/payments/bank_account_response_model.dart';
import '../../../../data/models/payments/create_payment_intent_request_model.dart';
import '../../../../data/models/payments/create_payment_intent_response_model.dart';
import '../../../../data/models/payments/payment_method_model.dart';
import '../../../../data/models/payments/payment_method_request_model.dart';
import '../../../../data/models/payments/payment_method_response_model.dart';
import '../../../../data/models/payments/process_payment_request_model.dart';
import '../../../../data/models/payments/process_payment_response_model.dart';
import '../../../../data/models/payments/set_default_payment_method_request_model.dart';
import '../../../../data/models/payments/set_default_payment_method_response_model.dart';
import '../../../../data/models/payments/verify_payment_method_response_model.dart';
import '../../../../data/models/payments/web_hook_res.dart';
import '../../../../data/models/payments/withdraw_req.dart';
import '../../../../data/models/payments/withdraw_res.dart';

class BankAccountProvider extends ChangeNotifier {
  final BankAccountRepository paymentRepository = BankAccountRepositoryImpl();


  bool _isLoading = false;
  String _errorMessage = '';
  BankAccountResponseModel? _response;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  BankAccountResponseModel? get response => _response;

  PaymentMethodResponseModel? _responsePayment;
  PaymentMethodResponseModel? get responsePayment => _responsePayment;

  CreatePaymentIntentResponseModel? _createPaymentResponse;
  CreatePaymentIntentResponseModel? get createPaymentResponse => _createPaymentResponse;

  List<PaymentMethodModel> _methods = [];
  List<PaymentMethodModel> get methods => _methods;

  ProcessPaymentResponseModel? _processPaymentResponse;
  ProcessPaymentResponseModel? get processPaymentResponse => _processPaymentResponse;

  SetDefaultPaymentMethodResponseModel? _setDefaultResponse;
  SetDefaultPaymentMethodResponseModel? get setDefaultResponse => _setDefaultResponse;

  VerifyPaymentMethodResponseModel? _verifiedMethod;
  VerifyPaymentMethodResponseModel? get verifiedMethod => _verifiedMethod;

  WebhookResponseModel? _webhookResponse;
  WebhookResponseModel? get webhookResponse => _webhookResponse;

  WithdrawResponseModel? _withdrawResponse;
  WithdrawResponseModel? get withdrawResponse => _withdrawResponse;




  Future<void> addBankAccount(BankAccountRequestModel model) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _response = await paymentRepository.addBankAccount(model);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPaymentMethod(PaymentMethodRequestModel model) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _responsePayment = await paymentRepository.addPaymentMethod(model);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> createIntent(CreatePaymentIntentRequestModel model) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _createPaymentResponse = await paymentRepository.createPaymentIntent(model);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> loadPaymentMethods(String userId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _methods = await paymentRepository.getUserPaymentMethods(userId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> processPayment(String userId, String paymentMethodId, int amount) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final req = ProcessPaymentRequestModel(
        userId: userId,
        paymentMethodId: paymentMethodId,
        amount: amount,
      );

      _processPaymentResponse = await paymentRepository.processPayment(req);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> setDefaultPaymentMethod(String userId, String paymentMethodId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final req = SetDefaultPaymentMethodRequestModel(
        userId: userId,
        paymentMethodId: paymentMethodId,
      );
      _setDefaultResponse = await paymentRepository.setDefaultPaymentMethod(req);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyPaymentMethod(String paymentMethodId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _verifiedMethod = await paymentRepository.verifyPaymentMethod(paymentMethodId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> sendWebhook({
    required String signature,
    required Map<String, dynamic> payload,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _webhookResponse = await paymentRepository.handleStripeWebhook(
        stripeSignature: signature,
        payload: payload,
      );
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> withdraw({required String userId, required int amount}) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final request = WithdrawRequestModel(userId: userId, amount: amount);
      _withdrawResponse = await paymentRepository.withdrawFunds(request);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
