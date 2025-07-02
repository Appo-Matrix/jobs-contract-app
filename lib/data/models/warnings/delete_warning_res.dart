class DeleteWarningResponse {
  final String message;

  DeleteWarningResponse({required this.message});

  factory DeleteWarningResponse.fromJson(Map<String, dynamic> json) {
    return DeleteWarningResponse(
      message: json['message'],
    );
  }
}
