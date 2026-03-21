// lib/config/providers/app_providers.dart

import 'package:flutter/material.dart';
import 'package:job_contract_app/presentation/features/users/providers/ad_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/application_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/bank_account_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/chat_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/contract_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/contractor_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/current_user_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/delivery_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/experience_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/featured_company_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/feedback_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/hired_talent_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/invitation_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/job_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/language_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/location_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/message_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/notification_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/offer_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/portfolio_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/preferences_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/qualification_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/reports_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/saved_talent_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/skill_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/subscription_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/talent_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/ticket_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/top_performer_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/user_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/visitor_analytics_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/warning_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// ─── Auth Providers ───────────────────────────────────────────────────────
import 'package:job_contract_app/presentation/features/auth/providers/auth_provider.dart';
import 'package:job_contract_app/presentation/features/auth/providers/google_signin_provider.dart';
import 'package:job_contract_app/presentation/features/auth/providers/register_provider.dart';
import 'package:job_contract_app/presentation/features/auth/providers/send_otp_provider.dart';
import 'package:job_contract_app/presentation/features/auth/providers/send_otp_sms_provider.dart';
import 'package:job_contract_app/presentation/features/auth/providers/update_password_provider.dart';


  /// Returns a list of all providers for the app
  List<SingleChildWidget> getProviders() {
    return [

      // ======================================================================
      // AUTH
      // ======================================================================

      ChangeNotifierProvider<AuthProvider>(
        create: (_) => AuthProvider(),
      ),

      ChangeNotifierProvider<GoogleSignInProvider>(
        create: (_) => GoogleSignInProvider(),
      ),

      ChangeNotifierProvider<RegisterProvider>(
        create: (_) => RegisterProvider(),
      ),

      ChangeNotifierProvider<SendOtpProvider>(
        create: (_) => SendOtpProvider(),
      ),

      ChangeNotifierProvider<SendOtpSmsProvider>(
        create: (_) => SendOtpSmsProvider(),
      ),

      ChangeNotifierProvider<UpdatePasswordProvider>(
        create: (_) => UpdatePasswordProvider(),
      ),

      // ======================================================================
      // ADS
      // ======================================================================

      ChangeNotifierProvider<AdProvider>(
        create: (_) => AdProvider(),
      ),

      // ======================================================================
      // APPLICATION
      // ======================================================================

      ChangeNotifierProvider<ApplicationProvider>(
        create: (_) => ApplicationProvider(),
      ),

      // ======================================================================
      // BANK ACCOUNT
      // ======================================================================

      ChangeNotifierProvider<BankAccountProvider>(
        create: (_) => BankAccountProvider(),
      ),

      // ======================================================================
      // CHAT
      // ======================================================================

      ChangeNotifierProvider<ChatProvider>(
        create: (_) => ChatProvider(),
      ),

      // ======================================================================
      // CONTRACT
      // ======================================================================

      ChangeNotifierProvider<ContractProvider>(
        create: (_) => ContractProvider(),
      ),

      // ======================================================================
      // CONTRACTOR
      // ======================================================================

      ChangeNotifierProvider<ContractorProvider>(
        create: (_) => ContractorProvider(),
      ),

      // ======================================================================
      // CURRENT USER
      // ======================================================================

      ChangeNotifierProvider<CurrentUserProvider>(
        create: (_) => CurrentUserProvider(),
      ),

      // ======================================================================
      // DELIVERY
      // ======================================================================

      ChangeNotifierProvider<DeliveryProvider>(
        create: (_) => DeliveryProvider(),
      ),

      // ======================================================================
      // EXPERIENCE
      // ======================================================================

      ChangeNotifierProvider<ExperienceProvider>(
        create: (_) => ExperienceProvider(),
      ),

      // ======================================================================
      // FEATURED COMPANY
      // ======================================================================

      ChangeNotifierProvider<FeaturedCompanyProvider>(
        create: (_) => FeaturedCompanyProvider(),
      ),

      // ======================================================================
      // FEEDBACK
      // ======================================================================

      ChangeNotifierProvider<FeedbackProvider>(
        create: (_) => FeedbackProvider(),
      ),

      // ======================================================================
      // HIRED TALENT
      // ======================================================================

      ChangeNotifierProvider<HiredTalentProvider>(
        create: (_) => HiredTalentProvider(),
      ),

      // ======================================================================
      // INVITATION
      // ======================================================================

      ChangeNotifierProvider<InvitationProvider>(
        create: (_) => InvitationProvider(),
      ),

      // ======================================================================
      // JOB
      // ======================================================================

      ChangeNotifierProvider<JobProvider>(
        create: (_) => JobProvider(),
      ),

      // ======================================================================
      // LANGUAGE
      // ======================================================================

      ChangeNotifierProvider<LanguageProvider>(
        create: (_) => LanguageProvider(),
      ),

      // ======================================================================
      // LOCATION
      // ======================================================================

      ChangeNotifierProvider<LocationProvider>(
        create: (_) => LocationProvider(),
      ),

      // ======================================================================
      // MESSAGE
      // ======================================================================

      ChangeNotifierProvider<MessageProvider>(
        create: (_) => MessageProvider(),
      ),

      // ======================================================================
      // NOTIFICATION
      // ======================================================================

      ChangeNotifierProvider<NotificationProvider>(
        create: (_) => NotificationProvider(),
      ),

      // ======================================================================
      // OFFER
      // ======================================================================

      ChangeNotifierProvider<OfferProvider>(
        create: (_) => OfferProvider(),
      ),

      // ======================================================================
      // PORTFOLIO
      // ======================================================================

      ChangeNotifierProvider<PortfolioProvider>(
        create: (_) => PortfolioProvider(),
      ),

      // ======================================================================
      // PREFERENCES
      // ======================================================================

      ChangeNotifierProvider<PreferencesProvider>(
        create: (_) => PreferencesProvider(),
      ),

      // ======================================================================
      // QUALIFICATION
      // ======================================================================

      ChangeNotifierProvider<QualificationProvider>(
        create: (_) => QualificationProvider(),
      ),

      // ======================================================================
      // REPORTS
      // ======================================================================

      ChangeNotifierProvider<ReportsProvider>(
        create: (_) => ReportsProvider(),
      ),

      // ======================================================================
      // SAVED TALENT
      // ======================================================================

      ChangeNotifierProvider<SavedTalentsProvider>(
        create: (_) => SavedTalentsProvider(),
      ),

      // ======================================================================
      // SKILL
      // ======================================================================

      ChangeNotifierProvider<SkillProvider>(
        create: (_) => SkillProvider(),
      ),

      // ======================================================================
      // SUBSCRIPTION
      // ======================================================================

      ChangeNotifierProvider<SubscriptionProvider>(
        create: (_) => SubscriptionProvider(),
      ),

      // ======================================================================
      // TALENT
      // ======================================================================

      ChangeNotifierProvider<TalentProvider>(
        create: (_) => TalentProvider(),
      ),

      // ======================================================================
      // TICKET
      // ======================================================================

      ChangeNotifierProvider<TicketProvider>(
        create: (_) => TicketProvider(),
      ),

      // ======================================================================
      // TOP PERFORMER
      // ======================================================================

      ChangeNotifierProvider<TopPerformerProvider>(
        create: (_) => TopPerformerProvider(),
      ),

      // ======================================================================
      // USER
      // ======================================================================

      ChangeNotifierProvider<UserProvider>(
        create: (_) => UserProvider(),
      ),

      // ======================================================================
      // VISITOR ANALYTICS
      // ======================================================================

      ChangeNotifierProvider<VisitorAnalyticsProvider>(
        create: (_) => VisitorAnalyticsProvider(),
      ),

      // ======================================================================
      // WARNING
      // ======================================================================

      ChangeNotifierProvider<WarningProvider>(
        create: (_) => WarningProvider(),
      ),
    ];
  }

  /// Wraps your entire app with all providers
  Widget wrapWithProviders({required Widget child}) {
    return MultiProvider(providers: getProviders(), child: child);
  }
