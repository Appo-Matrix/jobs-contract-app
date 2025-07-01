// data/models/deliveries/create_delivery_request.dart

class CreateDeliveryRequest {
  final String jobId;
  final String deliveredBy;
  final String deliveredTo;
  final String attachment;
  final String message;
  final String status;

  CreateDeliveryRequest({
    required this.jobId,
    required this.deliveredBy,
    required this.deliveredTo,
    required this.attachment,
    required this.message,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "jobId": jobId,
      "deliveredBy": deliveredBy,
      "deliveredTo": deliveredTo,
      "attachment": attachment,
      "message": message,
      "status": status,
    };
  }
}
