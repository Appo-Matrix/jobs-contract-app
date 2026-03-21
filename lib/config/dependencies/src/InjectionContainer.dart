// lib/config/dependencies/di.dart

import 'package:flutter/material.dart';



import '../../../data/repositories/ad_repository_impl.dart';
import '../../../data/repositories/application_repository_impl.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../data/repositories/bank_account_repository_impl.dart';
import '../../../data/repositories/certificate_repository_impl.dart';
import '../../../data/repositories/chat_repository_impl.dart';
import '../../../data/repositories/contract_repository_impl.dart';
import '../../../data/repositories/delivery_repository_impl.dart';
import '../../../data/repositories/email_repository_impl.dart';
import '../../../data/repositories/experience_repository_impl.dart';
import '../../../data/repositories/feedback_repository_impl.dart';
import '../../../data/repositories/invitation_repository_impl.dart';
import '../../../data/repositories/job_repository_impl.dart';
import '../../../data/repositories/language_repository_impl.dart';
import '../../../data/repositories/location_repository_impl.dart';
import '../../../data/repositories/message_repository_impl.dart';
import '../../../data/repositories/notification_repo_impl.dart';
import '../../../data/repositories/offer_repo_impl.dart';
import '../../../data/repositories/portfolio_repo_impl.dart';
import '../../../data/repositories/preferences_repository_impl.dart';
import '../../../data/repositories/qualification_repository_impl.dart';
import '../../../data/repositories/reports_repository_impl.dart';
import '../../../data/repositories/search_repository_impl.dart';
import '../../../data/repositories/skill_repository_impl.dart';
import '../../../data/repositories/subscription_repo_impl.dart';
import '../../../data/repositories/talent_repository_impl.dart';
import '../../../data/repositories/ticket_repository_impl.dart';
import '../../../data/repositories/user_repository_impl.dart';
import '../../../data/repositories/visitor_analytics_repository_impl.dart';
import '../../../data/repositories/warning_repository_impl.dart';

// ─── Abstract Repositories ─────────────────────────────────────────────────
import '../../../domain/repository/ads_repository.dart';
import '../../../domain/repository/application_repository.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../../domain/repository/bank_account_repository.dart';
import '../../../domain/repository/certificate_repository.dart';
import '../../../domain/repository/chat_repository.dart';
import '../../../domain/repository/contract_repository.dart';
import '../../../domain/repository/delivery_repository.dart';
import '../../../domain/repository/email_repository.dart';
import '../../../domain/repository/experience_repository.dart';
import '../../../domain/repository/feedback_repository.dart';
import '../../../domain/repository/invitation_repository.dart';
import '../../../domain/repository/job_repository.dart';
import '../../../domain/repository/language_repository.dart';
import '../../../domain/repository/location_repository.dart';
import '../../../domain/repository/message_repository.dart';
import '../../../domain/repository/notification_repository.dart';
import '../../../domain/repository/offer_repository.dart';
import '../../../domain/repository/portfolio_repository.dart';
import '../../../domain/repository/preferences_repository.dart';
import '../../../domain/repository/qualification_repository.dart';
import '../../../domain/repository/reports_repository.dart';
import '../../../domain/repository/search_repository.dart';
import '../../../domain/repository/skill_repository.dart';
import '../../../domain/repository/subscription_repository.dart';
import '../../../domain/repository/talent_repository.dart';
import '../../../domain/repository/ticket_repository.dart';
import '../../../domain/repository/user_repository.dart';
import '../../../domain/repository/visitor_analytics_repository.dart';
import '../../../domain/repository/warning_repository.dart';

class InjectionContainer {
  // ─── Singleton ────────────────────────────────────────────────────────────
  static final InjectionContainer _instance = InjectionContainer._internal();
  factory InjectionContainer() => _instance;
  InjectionContainer._internal();

  // ─── Abstract Repositories ────────────────────────────────────────────────
  late final AdRepository _adsRepository;
  late final ApplicationRepository _applicationRepository;
  late final AuthRepository _authRepository;
  late final BankAccountRepository _bankAccountRepository;
  late final CertificateRepository _certificateRepository;
  late final ChatRepository _chatRepository;
  late final ContractRepository _contractRepository;
  late final DeliveryRepository _deliveryRepository;
  late final EmailRepository _emailRepository;
  late final ExperienceRepository _experienceRepository;
  late final FeedbackRepository _feedbackRepository;
  late final InvitationRepository _invitationRepository;
  late final JobRepository _jobRepository;
  late final LanguageRepository _languageRepository;
  late final LocationRepository _locationRepository;
  late final MessageRepository _messageRepository;
  late final NotificationRepository _notificationRepository;
  late final OfferRepository _offerRepository;
  late final PortfolioRepository _portfolioRepository;
  late final PreferencesRepository _preferencesRepository;
  late final QualificationRepository _qualificationRepository;
  late final ReportsRepository _reportsRepository;
  late final SearchRepository _searchRepository;
  late final SkillRepository _skillRepository;
  late final SubscriptionRepository _subscriptionRepository;
  late final TalentRepository _talentRepository;
  late final TicketRepository _ticketRepository;
  late final UserRepository _userRepository;
  late final VisitorAnalyticsRepository _visitorAnalyticsRepository;
  late final WarningRepository _warningRepository;

  // ─── Getters — Repositories ───────────────────────────────────────────────
  AdRepository get adsRepository => _adsRepository;
  ApplicationRepository get applicationRepository => _applicationRepository;
  AuthRepository get authRepository => _authRepository;
  BankAccountRepository get bankAccountRepository => _bankAccountRepository;
  CertificateRepository get certificateRepository => _certificateRepository;
  ChatRepository get chatRepository => _chatRepository;
  ContractRepository get contractRepository => _contractRepository;
  DeliveryRepository get deliveryRepository => _deliveryRepository;
  EmailRepository get emailRepository => _emailRepository;
  ExperienceRepository get experienceRepository => _experienceRepository;
  FeedbackRepository get feedbackRepository => _feedbackRepository;
  InvitationRepository get invitationRepository => _invitationRepository;
  JobRepository get jobRepository => _jobRepository;
  LanguageRepository get languageRepository => _languageRepository;
  LocationRepository get locationRepository => _locationRepository;
  MessageRepository get messageRepository => _messageRepository;
  NotificationRepository get notificationRepository => _notificationRepository;
  OfferRepository get offerRepository => _offerRepository;
  PortfolioRepository get portfolioRepository => _portfolioRepository;
  PreferencesRepository get preferencesRepository => _preferencesRepository;
  QualificationRepository get qualificationRepository => _qualificationRepository;
  ReportsRepository get reportsRepository => _reportsRepository;
  SearchRepository get searchRepository => _searchRepository;
  SkillRepository get skillRepository => _skillRepository;
  SubscriptionRepository get subscriptionRepository => _subscriptionRepository;
  TalentRepository get talentRepository => _talentRepository;
  TicketRepository get ticketRepository => _ticketRepository;
  UserRepository get userRepository => _userRepository;
  VisitorAnalyticsRepository get visitorAnalyticsRepository => _visitorAnalyticsRepository;
  WarningRepository get warningRepository => _warningRepository;

  // ─── Init ─────────────────────────────────────────────────────────────────
  Future<void> init() async {
    debugPrint('');
    debugPrint('🚀 STARTING DEPENDENCY INJECTION SETUP...');
    debugPrint('');

    await _initAdsModule();
    await _initApplicationModule();
    await _initAuthModule();
    await _initBankAccountModule();
    await _initCertificateModule();
    await _initChatModule();
    await _initContractModule();
    await _initDeliveryModule();
    await _initEmailModule();
    await _initExperienceModule();
    await _initFeedbackModule();
    await _initInvitationModule();
    await _initJobModule();
    await _initLanguageModule();
    await _initLocationModule();
    await _initMessageModule();
    await _initNotificationModule();
    await _initOfferModule();
    await _initPortfolioModule();
    await _initPreferencesModule();
    await _initQualificationModule();
    await _initReportsModule();
    await _initSearchModule();
    await _initSkillModule();
    await _initSubscriptionModule();
    await _initTalentModule();
    await _initTicketModule();
    await _initUserModule();
    await _initVisitorAnalyticsModule();
    await _initWarningModule();

    debugPrint('');
    debugPrint('🎉 DEPENDENCY INJECTION SETUP COMPLETE 🎉');
    debugPrint('');
  }

  // ─── Ads ──────────────────────────────────────────────────────────────────
  Future<void> _initAdsModule() async {
    debugPrint('📢 Initializing Ads Module...');
    _adsRepository = AdRepositoryImpl();
    debugPrint('   ✔ AdRepository initialized');
    debugPrint('');
  }

  // ─── Application ──────────────────────────────────────────────────────────
  Future<void> _initApplicationModule() async {
    debugPrint('📋 Initializing Application Module...');
    _applicationRepository = ApplicationRepositoryImpl();
    debugPrint('   ✔ ApplicationRepository initialized');
    debugPrint('');
  }

  // ─── Auth ─────────────────────────────────────────────────────────────────
  Future<void> _initAuthModule() async {
    debugPrint('🔐 Initializing Auth Module...');
    _authRepository = AuthRepositoryImpl();
    debugPrint('   ✔ AuthRepository initialized');
    debugPrint('');
  }

  // ─── Bank Account ─────────────────────────────────────────────────────────
  Future<void> _initBankAccountModule() async {
    debugPrint('🏦 Initializing Bank Account Module...');
    _bankAccountRepository = BankAccountRepositoryImpl();
    debugPrint('   ✔ BankAccountRepository initialized');
    debugPrint('');
  }

  // ─── Certificate ──────────────────────────────────────────────────────────
  Future<void> _initCertificateModule() async {
    debugPrint('🎓 Initializing Certificate Module...');
    _certificateRepository = CertificateRepositoryImpl();
    debugPrint('   ✔ CertificateRepository initialized');
    debugPrint('');
  }

  // ─── Chat ─────────────────────────────────────────────────────────────────
  Future<void> _initChatModule() async {
    debugPrint('💬 Initializing Chat Module...');
    _chatRepository = ChatRepositoryImpl();
    debugPrint('   ✔ ChatRepository initialized');
    debugPrint('');
  }

  // ─── Contract ─────────────────────────────────────────────────────────────
  Future<void> _initContractModule() async {
    debugPrint('📄 Initializing Contract Module...');
    _contractRepository = ContractRepositoryImpl();
    debugPrint('   ✔ ContractRepository initialized');
    debugPrint('');
  }

  // ─── Delivery ─────────────────────────────────────────────────────────────
  Future<void> _initDeliveryModule() async {
    debugPrint('🚚 Initializing Delivery Module...');
    _deliveryRepository = DeliveryRepositoryImpl();
    debugPrint('   ✔ DeliveryRepository initialized');
    debugPrint('');
  }

  // ─── Email ────────────────────────────────────────────────────────────────
  Future<void> _initEmailModule() async {
    debugPrint('📧 Initializing Email Module...');
    _emailRepository = EmailRepositoryImpl();
    debugPrint('   ✔ EmailRepository initialized');
    debugPrint('');
  }

  // ─── Experience ───────────────────────────────────────────────────────────
  Future<void> _initExperienceModule() async {
    debugPrint('💼 Initializing Experience Module...');
    _experienceRepository = ExperienceRepositoryImpl();
    debugPrint('   ✔ ExperienceRepository initialized');
    debugPrint('');
  }

  // ─── Feedback ─────────────────────────────────────────────────────────────
  Future<void> _initFeedbackModule() async {
    debugPrint('⭐ Initializing Feedback Module...');
    _feedbackRepository = FeedbackRepositoryImpl();
    debugPrint('   ✔ FeedbackRepository initialized');
    debugPrint('');
  }

  // ─── Invitation ───────────────────────────────────────────────────────────
  Future<void> _initInvitationModule() async {
    debugPrint('✉️  Initializing Invitation Module...');
    _invitationRepository = InvitationRepositoryImpl();
    debugPrint('   ✔ InvitationRepository initialized');
    debugPrint('');
  }

  // ─── Job ──────────────────────────────────────────────────────────────────
  Future<void> _initJobModule() async {
    debugPrint('🧳 Initializing Job Module...');
    _jobRepository = JobRepositoryImpl();
    debugPrint('   ✔ JobRepository initialized');
    debugPrint('');
  }

  // ─── Language ─────────────────────────────────────────────────────────────
  Future<void> _initLanguageModule() async {
    debugPrint('🌐 Initializing Language Module...');
    _languageRepository = LanguageRepositoryImpl();
    debugPrint('   ✔ LanguageRepository initialized');
    debugPrint('');
  }

  // ─── Location ─────────────────────────────────────────────────────────────
  Future<void> _initLocationModule() async {
    debugPrint('📍 Initializing Location Module...');
    _locationRepository = LocationRepositoryImpl();
    debugPrint('   ✔ LocationRepository initialized');
    debugPrint('');
  }

  // ─── Message ──────────────────────────────────────────────────────────────
  Future<void> _initMessageModule() async {
    debugPrint('💬 Initializing Message Module...');
    _messageRepository = MessageRepositoryImpl();
    debugPrint('   ✔ MessageRepository initialized');
    debugPrint('');
  }

  // ─── Notification ─────────────────────────────────────────────────────────
  Future<void> _initNotificationModule() async {
    debugPrint('🔔 Initializing Notification Module...');
    _notificationRepository = NotificationRepositoryImpl();
    debugPrint('   ✔ NotificationRepository initialized');
    debugPrint('');
  }

  // ─── Offer ────────────────────────────────────────────────────────────────
  Future<void> _initOfferModule() async {
    debugPrint('🤝 Initializing Offer Module...');
    _offerRepository = OfferRepositoryImpl();
    debugPrint('   ✔ OfferRepository initialized');
    debugPrint('');
  }

  // ─── Portfolio ────────────────────────────────────────────────────────────
  Future<void> _initPortfolioModule() async {
    debugPrint('🖼️  Initializing Portfolio Module...');
    _portfolioRepository = PortfolioRepositoryImpl();
    debugPrint('   ✔ PortfolioRepository initialized');
    debugPrint('');
  }

  // ─── Preferences ──────────────────────────────────────────────────────────
  Future<void> _initPreferencesModule() async {
    debugPrint('⚙️  Initializing Preferences Module...');
    _preferencesRepository = PreferencesRepositoryImpl();
    debugPrint('   ✔ PreferencesRepository initialized');
    debugPrint('');
  }

  // ─── Qualification ────────────────────────────────────────────────────────
  Future<void> _initQualificationModule() async {
    debugPrint('🎓 Initializing Qualification Module...');
    _qualificationRepository = QualificationRepositoryImpl();
    debugPrint('   ✔ QualificationRepository initialized');
    debugPrint('');
  }

  // ─── Reports ──────────────────────────────────────────────────────────────
  Future<void> _initReportsModule() async {
    debugPrint('📊 Initializing Reports Module...');
    _reportsRepository = ReportsRepositoryImpl();
    debugPrint('   ✔ ReportsRepository initialized');
    debugPrint('');
  }

  // ─── Search ───────────────────────────────────────────────────────────────
  Future<void> _initSearchModule() async {
    debugPrint('🔍 Initializing Search Module...');
    _searchRepository = SearchRepositoryImpl();
    debugPrint('   ✔ SearchRepository initialized');
    debugPrint('');
  }

  // ─── Skill ────────────────────────────────────────────────────────────────
  Future<void> _initSkillModule() async {
    debugPrint('🛠️  Initializing Skill Module...');
    _skillRepository = SkillRepositoryImpl();
    debugPrint('   ✔ SkillRepository initialized');
    debugPrint('');
  }

  // ─── Subscription ─────────────────────────────────────────────────────────
  Future<void> _initSubscriptionModule() async {
    debugPrint('💳 Initializing Subscription Module...');
    _subscriptionRepository = SubscriptionRepositoryImpl();
    debugPrint('   ✔ SubscriptionRepository initialized');
    debugPrint('');
  }

  // ─── Talent ───────────────────────────────────────────────────────────────
  Future<void> _initTalentModule() async {
    debugPrint('👤 Initializing Talent Module...');
    _talentRepository = TalentRepositoryImpl();
    debugPrint('   ✔ TalentRepository initialized');
    debugPrint('');
  }

  // ─── Ticket ───────────────────────────────────────────────────────────────
  Future<void> _initTicketModule() async {
    debugPrint('🎫 Initializing Ticket Module...');
    _ticketRepository = TicketRepositoryImpl();
    debugPrint('   ✔ TicketRepository initialized');
    debugPrint('');
  }

  // ─── User ─────────────────────────────────────────────────────────────────
  Future<void> _initUserModule() async {
    debugPrint('🙍 Initializing User Module...');
    _userRepository = UserRepositoryImpl();
    debugPrint('   ✔ UserRepository initialized');
    debugPrint('');
  }

  // ─── Visitor Analytics ────────────────────────────────────────────────────
  Future<void> _initVisitorAnalyticsModule() async {
    debugPrint('📈 Initializing Visitor Analytics Module...');
    _visitorAnalyticsRepository = VisitorAnalyticsRepositoryImpl();
    debugPrint('   ✔ VisitorAnalyticsRepository initialized');
    debugPrint('');
  }

  // ─── Warning ──────────────────────────────────────────────────────────────
  Future<void> _initWarningModule() async {
    debugPrint('⚠️  Initializing Warning Module...');
    _warningRepository = WarningRepositoryImpl();
    debugPrint('   ✔ WarningRepository initialized');
    debugPrint('');
  }

  void reset() {
    debugPrint('🔄 Resetting Dependency Injection Container...');
  }
}

// Global instance
final injectionContainer = InjectionContainer();