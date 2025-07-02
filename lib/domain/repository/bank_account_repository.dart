
import '../../data/models/payments/bank_account_request_model.dart';
import '../../data/models/payments/bank_account_response_model.dart';
import '../../data/models/payments/create_payment_intent_request_model.dart';
import '../../data/models/payments/create_payment_intent_response_model.dart';
import '../../data/models/payments/payment_method_model.dart';
import '../../data/models/payments/payment_method_request_model.dart';
import '../../data/models/payments/payment_method_response_model.dart';
import '../../data/models/payments/process_payment_request_model.dart';
import '../../data/models/payments/process_payment_response_model.dart';
import '../../data/models/payments/set_default_payment_method_request_model.dart';
import '../../data/models/payments/set_default_payment_method_response_model.dart';
import '../../data/models/payments/verify_payment_method_response_model.dart';
import '../../data/models/payments/web_hook_res.dart';
import '../../data/models/payments/withdraw_req.dart';
import '../../data/models/payments/withdraw_res.dart';

abstract class BankAccountRepository {

  Future<BankAccountResponseModel> addBankAccount(BankAccountRequestModel model);

  Future<PaymentMethodResponseModel> addPaymentMethod(PaymentMethodRequestModel model);

  Future<CreatePaymentIntentResponseModel> createPaymentIntent(CreatePaymentIntentRequestModel model);

  Future<List<PaymentMethodModel>> getUserPaymentMethods(String userId);

  Future<ProcessPaymentResponseModel> processPayment(ProcessPaymentRequestModel model);

  Future<SetDefaultPaymentMethodResponseModel> setDefaultPaymentMethod(SetDefaultPaymentMethodRequestModel model);

  Future<VerifyPaymentMethodResponseModel> verifyPaymentMethod(String paymentMethodId);

  Future<WebhookResponseModel> handleStripeWebhook({required String stripeSignature, required Map<String, dynamic> payload});

  Future<WithdrawResponseModel> withdrawFunds(WithdrawRequestModel model);

}
