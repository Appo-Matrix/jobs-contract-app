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
  static String getFeaturedCompanies = "/companies/featured";
  static String getTopPerformers = "/users/top-performers";
  static String getCurrentUser = "/users/me";
  static String updateCurrentUserProfile = "/users/me";
  static const String logout = "/auth/logout";
  static const String uploadResume = "/users/upload-resume";

  // Search
  static const String search = "/search";
  static const String getUserSearches = "/search";
  static const String removeSearch = "/search/remove";

  // Certificate
  static const String addCertificate = "/certificates/add";
  static String getUserCertificates(String userId) => "/certificates/user/$userId";
  static String deleteCertificate(String id) => "/certificates/$id";
  static String updateCertificate(String id) => '/certificates/$id';










}