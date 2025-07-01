// models/contracts/update_payment_status_request.dart

class UpdatePaymentStatusRequest {
  final String paymentStatus; // "pending" or "paid"

  UpdatePaymentStatusRequest({required this.paymentStatus});

  Map<String, dynamic> toJson() => {
    'paymentStatus': paymentStatus,
  };
}
