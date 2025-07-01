class CompleteContractResponse {
  final String message;
  final String data;

  CompleteContractResponse({
    required this.message,
    required this.data,
  });

  factory CompleteContractResponse.fromJson(Map<String, dynamic> json) {
    return CompleteContractResponse(
      message: json['message'],
      data: json['data'],
    );
  }
}
