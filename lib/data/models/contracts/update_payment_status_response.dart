// models/contracts/update_payment_status_response.dart

class UpdatePaymentStatusResponse {
  final bool success;
  final String message;
  final PaymentStatusData data;

  UpdatePaymentStatusResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UpdatePaymentStatusResponse.fromJson(Map<String, dynamic> json) {
    return UpdatePaymentStatusResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: PaymentStatusData.fromJson(json['data']),
    );
  }
}

class PaymentStatusData {
  final String id;
  final PaymentDetails paymentDetails;

  PaymentStatusData({required this.id, required this.paymentDetails});

  factory PaymentStatusData.fromJson(Map<String, dynamic> json) {
    return PaymentStatusData(
      id: json['_id'] ?? '',
      paymentDetails: PaymentDetails.fromJson(json['paymentDetails']),
    );
  }
}

class PaymentDetails {
  final String paymentStatus;

  PaymentDetails({required this.paymentStatus});

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      paymentStatus: json['paymentStatus'] ?? '',
    );
  }
}
