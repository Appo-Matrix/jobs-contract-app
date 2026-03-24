// class JobApplicationSubmitRequest {
//   final String jobId;
//   final String coverLetter;
//
//   JobApplicationSubmitRequest({
//     required this.jobId,
//     required this.coverLetter,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'jobId': jobId,
//       'coverLetter': coverLetter,
//     };
//   }
// }


class JobApplicationSubmitRequest {
  final String jobId;
  final String coverLetter;
  final double? estimatedServiceCost;
  final String? estimatedCompletionTime;

  JobApplicationSubmitRequest({
    required this.jobId,
    required this.coverLetter,
    this.estimatedServiceCost,
    this.estimatedCompletionTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'jobId': jobId,
      'coverLetter': coverLetter,
      if (estimatedServiceCost != null) 'estimatedServiceCost': estimatedServiceCost,
      if (estimatedCompletionTime != null) 'estimatedCompletionTime': estimatedCompletionTime,
    };
  }
}
