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
}