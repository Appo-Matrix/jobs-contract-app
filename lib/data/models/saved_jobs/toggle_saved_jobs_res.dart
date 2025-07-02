class ToggleSaveJobResponse {
  final bool success;
  final String message;
  final SavedJobData? data;

  ToggleSaveJobResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ToggleSaveJobResponse.fromJson(Map<String, dynamic> json) {
    return ToggleSaveJobResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? SavedJobData.fromJson(json['data']) : null,
    );
  }
}

class SavedJobData {
  final String id;
  final String job;
  final String user;

  SavedJobData({
    required this.id,
    required this.job,
    required this.user,
  });

  factory SavedJobData.fromJson(Map<String, dynamic> json) {
    return SavedJobData(
      id: json['_id'],
      job: json['job'],
      user: json['user'],
    );
  }
}
