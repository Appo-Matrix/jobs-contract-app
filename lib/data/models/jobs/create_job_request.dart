class CreateJobRequest {
  final String title;
  final String description;
  final String jobType;
  final String jobDuration;
  final String jobCategory;
  final List<String> skillsRequired;
  final String date;
  final String attachment;
  final String jobPosition;
  final String typeOfWorkPlace;
  final String jobLocation;
  final String company;
  final String employmentType;
  final String salary;
  final String qualification;
  final String eligibility;
  final String experience;
  final String specializaion;
  final List<String> facilities;

  CreateJobRequest({
    required this.title,
    required this.description,
    required this.jobType,
    required this.jobDuration,
    required this.jobCategory,
    required this.skillsRequired,
    required this.date,
    required this.attachment,
    required this.jobPosition,
    required this.typeOfWorkPlace,
    required this.jobLocation,
    required this.company,
    required this.employmentType,
    required this.salary,
    required this.qualification,
    required this.eligibility,
    required this.experience,
    required this.specializaion,
    required this.facilities,
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "jobType": jobType,
    "jobDuration": jobDuration,
    "jobCategory": jobCategory,
    "skillsRequired": skillsRequired,
    "date": date,
    "attachment": attachment,
    "jobPosition": jobPosition,
    "typeOfWorkPlace": typeOfWorkPlace,
    "jobLocation": jobLocation,
    "company": company,
    "employmentType": employmentType,
    "salary": salary,
    "Qualification": qualification,
    "eligibility": eligibility,
    "experience": experience,
    "specializaion": specializaion,
    "facilities": facilities,
  };
}
