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

  // Deliveries
  static const String createDelivery = "/deliveries";
  static String getDeliveriesByJob(String jobId) => "/deliveries/job/$jobId";
  static String deleteDeliveryById(String id) => '/deliveries/$id';

  // Education
  static const String addQualification = '/qualifications/add';
  static String deleteQualification(String eduId) => '/qualifications/$eduId';
  static String getQualificationById(String eduId) => '/qualifications/$eduId';
  static String updateQualification(String eduId) => '/qualifications/$eduId';
  static String getQualificationsByUserId(String userId) => '/qualifications/user/$userId';
  static const String getMyQualifications = '/qualifications/me';

  // Jobs
  static const String createJob = "/jobs/create";
  static const String adminMetrics = "/admins/metrics";
  static String deleteJob(String jobId) => '/jobs/$jobId';
  static String getJobById(String jobId) => '/jobs/$jobId';
  static String updateJob(String id) => '/jobs/$id';
  static String getAllJobs({int page = 1, int limit = 10, String sortBy = 'date', String sortOrder = 'desc'}) => '/jobs/all?page=$page&limit=$limit&sortBy=$sortBy&sortOrder=$sortOrder';
  static const String jobsByUser = '/jobs/me';
  static const String matchingJobs = '/jobs/matching';
  static String getRecentJobs({int page = 1, int limit = 10}) => '/jobs/recent?page=$page&limit=$limit';
  static const String searchJobs = '/jobs/search';
  static const String reportJob = '/api/jobs/report';

  // Ads
  static const String createAd = '/ads';
  static const String getAllAds = '/ads';
  static String deleteAd(String id) => '/ads/$id';
  static String getAdById(String id) => '/ads/$id';
  static String updateAd(String adId) => '/ads/$adId';
  static String getUserAds(String userId) => '/ads/user/$userId';
  static String getNearbyAds = '/ads/nearby';

  // Email Settings
  static const String updateEmailSettings = '/email-settings/';

  // Feedback
  static const String submitFeedback = '/feedbacks/add';
  static const String getAllFeedbacks = '/feedbacks/all';
  static const String getFeedbackById = '/feedbacks'; // Append /{feedbackId} dynamically
  static const String getUserFeedbacks = '/feedbacks/user';
  static String getUserRating(String userId) => '/feedbacks/rating/$userId';

  // Invitations
  static String acceptInvitation(String id) => '/invitations/$id/accept';
  static const String sendInvitation = '/invitations/send';
  static String deleteInvitation(String id) => '/invitations/$id';
  static const String getInvitationById = '/invitations'; // Will be used like: /invitations/{id}
  static const String getAllInvitations = '/invitations';
  static String getInvitationsByJob(String jobId) => '/invitations/job/$jobId';
  static const String userInvitations = '/invitations/user';
  static String rejectInvitation(String id) => '/invitations/$id/reject';

  // Job Applications
  static String getJobApplicationById(String id) => '/applications/$id';
  static String deleteJobApplication(String id) => '/applications/$id';
  static String updateJobApplication(String id) => '/applications/$id';
  static const String getApplicationsByJobId = '/applications'; // usage: /applications/{jobId}
  static const String myJobApplications = '/applications/me';
  static const String submitJobApplication = '/applications/apply';

  // Preferences
  static String deleteJobPreferences(String userId) => '/preferences/$userId';
  static String getUserPreferences(String userId) => '/preferences/$userId';
  static String searchUsersByJobPreference(String job) => '/preferences/search?job=$job';
  static const String updateRealEstatePreferences = '/preferences';

  // Languages
  static const String addLanguage = '/languages/';
  static String updateLanguage(String id) => '/languages/$id';
  static String deleteLanguage(String id) => '/languages/$id';
  static String getLanguage(String id) => '/languages/$id';
  static const String getMyLanguages = '/languages/me';

  // Locations
  static const String addLocation = '/locations/';
  static String deleteLocation(String userId) => '/locations/$userId';
  static String getLocationByUserId(String userId) => '/locations/$userId';
  static String updateLocation(String userId) => '/locations/$userId';
  static const String getAllLocations = '/locations';
  static const String getUserLocation = '/locations/me';






































}