class ApiPath{

  static String baseUrl = "http://localhost:3000/api/v1";


  //Auth
  static String login = "/auth/login";
  static String forgotPassword = "/auth/forgot-password";
  static String register = "/auth/register";
  static String resetPassword = "/auth/reset-password";
  static String sendOtpEmail = "/users/send-otp-email";
  static String sendOtpSms = "/users/send-otp-sms";
  static String googleSignIn = "/auth/google";
  static String updatePassword = "/users/update-password";

  // User
  static String deleteResume = "/users/delete-resume";
  static const String deleteUser = "/users"; // will use /users/{userId}
  static String updateUserProfile(String userId) => "/users/$userId";
  static const String getTalents = "/users/talent";
  static const String getHiredTalents = "/users/hired-talent";
  static String contractorsBySpeciality(String speciality) => "/contractors/$speciality";



}