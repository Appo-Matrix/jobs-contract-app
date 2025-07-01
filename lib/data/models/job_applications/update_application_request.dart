class UpdateApplicationRequest {
  final String coverLetter;

  UpdateApplicationRequest({required this.coverLetter});

  Map<String, dynamic> toJson() => {
    'coverLetter': coverLetter,
  };
}
