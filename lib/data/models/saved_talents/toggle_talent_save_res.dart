import 'package:job_contracts/data/models/saved_talents/saved_talent_res.dart';

class ToggleTalentSaveResponse {
  final bool success;
  final String message;
  final SavedTalent? data;

  ToggleTalentSaveResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ToggleTalentSaveResponse.fromJson(Map<String, dynamic> json) {
    return ToggleTalentSaveResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? SavedTalent.fromJson(json['data']) : null,
    );
  }
}
