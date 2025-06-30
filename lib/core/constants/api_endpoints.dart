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

  // Chat
  static const String createChat = '/chats/create';
  static const String deleteChatByJobId = '/chats'; // + /{jobId}
  static const String getAllChats = '/chats';

  // Contracts
  static String activateContract(String contractId) => '/contracts/$contractId/activate';
  static String cancelContractPath(String contractId) => '/api/contracts/$contractId/cancel';
  static String completeContract(String contractId) => '/contracts/$contractId/complete';
  static const String createContract = '/contracts';
  static String deleteContract(String contractId) => '/contracts/$contractId';
  static String getContractById(String contractId) => '/contracts/$contractId';
  static String endContract(String contractId) => '/contracts/end/$contractId';
  static const String getActiveContracts = '/contracts/active-contracts';
  static const String getAllContracts = '/contracts';
  static const String getCanceledContracts = '/contracts/canceled';
  static const String getCompletedContracts = '/contracts/completed';
  static String getContractsByJobId(String jobId) => '/contracts/job/$jobId';
  static String getContractsByUserId(String userId) => '/contracts/user/$userId';
  static const String getEndedContracts = '/contracts/ended';
  static String getPausedContracts(String userId) => '/contracts/paused/$userId';
  static String pauseContract(String contractId) => '/contracts/$contractId/pause';
  static String updateContract(String id) => '/contracts/$id';
  static String updateContractPayment(String contractId) => "/contracts/$contractId/payment";

  // Support Tickets
  static const String createSupportTicket = "/tickets";
  static String deleteTicket(String id) => "/tickets/$id";
  static String getTicketById(String id) => "/tickets/$id";
  static String updateTicket(String id) => "/tickets/$id";
  static const String getAllTickets = "/ticket";
  static const String getUserTickets = "/tickets/user";
  static String resolveTicket(String id) => "/tickets/$id/resolve";















}