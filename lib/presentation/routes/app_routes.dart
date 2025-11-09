import 'package:go_router/go_router.dart';
import 'package:job_contracts/core/constants/global.dart';
import 'package:job_contracts/presentation/features/auth/screens/forget_password/forget_password_screen.dart';
import 'package:job_contracts/presentation/features/auth/screens/onboarding/onboarding_screen.dart';

import 'package:job_contracts/presentation/routes/routes.dart';

import '../features/auth/screens/Login/login_screen.dart';
import '../features/auth/screens/address_form/address_form_screen.dart';
import '../features/auth/screens/forget_password/forget_password_otp_screen.dart';
import '../features/auth/screens/forget_password/reset_password.dart';
import '../features/auth/screens/newsignupscreen/new_signup_screen.dart';
import '../features/auth/screens/portfilo_screen/upload_portfolio_screen.dart';
import '../features/auth/screens/profile/profile_detail.dart';
import '../features/auth/screens/signup/company_signup_screen.dart';
import '../features/auth/screens/signup/contractor_signup_screen.dart';
import '../features/auth/screens/signup/email_verification_screen.dart';
import '../features/auth/screens/signup/signup_screen.dart';
import '../features/auth/screens/success/model/success_screen_args.dart';
import '../features/auth/screens/success/success_screen.dart';
import '../features/auth/screens/verification_screen/check_email_screen.dart';
import '../features/auth/screens/verification_screen/email_verified_screen.dart';
import '../features/auth/screens/verify_profile/screens/verify_identity.dart';
import '../features/auth/screens/verify_profile/screens/verify_payment_method.dart';
import '../features/auth/screens/verify_profile/screens/verify_phone_number.dart';
import '../features/auth/screens/otp/verify_phone_otp.dart';
import '../features/auth/screens/verify_profile/screens/verify_profile.dart';

import '../features/users/NavigationMenu.dart';
import '../features/users/account_screen/account_setting_screen.dart';
import '../features/users/account_screen/add_experiance_screen.dart';
import '../features/users/account_screen/change_work_experience_screen.dart';
import '../features/users/account_screen/changed_password_screen.dart';
import '../features/users/account_screen/preference_screen.dart';
import '../features/users/account_screen/profile_information_screen.dart';
import '../features/users/bank_account_info/bank_account_info.dart';

import '../features/users/bottom_nav/bottom_nav_bar.dart';
import '../features/users/contract/contact_detail_screens/contact_details_accepted_screen.dart';
import '../features/users/contract/contact_detail_screens/contact_details_active_screen.dart';
import '../features/users/contract/contact_detail_screens/contract_detail_screen.dart';
import '../features/users/contract/contact_detail_screens/deliver_contract_screen.dart';
import '../features/users/contract/contact_detail_screens/feed_back_screen.dart';
import '../features/users/finanance_report/finance_reports_screen.dart';
import '../features/users/finanance_report/withdrawal_screen.dart';
import '../features/users/helpandsupport/contact_support.dart';
import '../features/users/helpandsupport/reports_screen.dart';
import '../features/users/helpandsupport/support_request.dart';
import '../features/users/home/home_screen.dart';
import '../features/users/home/job_details/JobDetailScreen.dart';
import '../features/users/home/job_details/job_detail_page.dart';
import '../features/users/home/job_details/report_job_screen.dart';
import '../features/users/language/language_screen.dart';
import '../features/users/message/chat_screen.dart';
import '../features/users/myads/addetails_screen.dart';
import '../features/users/myads/adupload_screen.dart';
import '../features/users/myads/create_ad_screen.dart';
import '../features/users/myads/my_ads_screen.dart';
import '../features/users/payments/payments_method.dart';
import '../features/users/profile/profile_detail.dart';

import '../features/users/add_education/add_education.dart';
import '../features/users/add_social_account/add_social_account.dart';
import '../features/users/notification/notifcations.dart';
import '../features/users/proposalScreen/proposal_screen.dart';
import '../features/users/upgrade/membership_plans_screen.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    // initialLocation: '/onboardingScreen',
    initialLocation: '/navigationMenu',
    routes: [
      // User
      GoRoute(
        path: '/onboardingScreen',
        name: Routes.onboardingScreen.name,
       builder: (context, state) =>  OnboardingScreen(),
      ),
      GoRoute(
        path: '/loginScreen',
        name: Routes.loginScreen.name,
       builder: (context, state) => const LoginScreen(),
      ),


      GoRoute(
        path: '/signupScreen',
        name: Routes.signupScreen.name,
       builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/verifyProfile',
        name: Routes.verifyProfile.name,
       builder: (context, state) => const VerifyProfile(),
      ),
      GoRoute(
        path: '/verifyPhoneNumber',
        name: Routes.verifyPhoneNumber.name,
       builder: (context, state) => const VerifyPhoneNumber(),
      ),
      GoRoute(
        path: '/verifyPhoneOtp',
        name: Routes.verifyPhoneOtp.name,
       builder: (context, state) => const VerifyPhoneOtp(),
      ),

      GoRoute(
        path: '/verifyIdentity',
        name: Routes.verifyIdentity.name,
       builder: (context, state) => const VerifyIdentity(),
      ),
      GoRoute(
        path: '/newSignupScreen',
        name: Routes.newSignupScreen.name,
       builder: (context, state) => const NewSignupScreen(),
      ),
      GoRoute(
        path: '/verifyPaymentMethod',
        name: Routes.verifyPaymentMethod.name,
       builder: (context, state) => const VerifyPaymentMethod(),

      ),
      GoRoute(
        path: '/resetPasswordScreen',
        name: Routes.resetPasswordScreen.name,
       builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: '/successScreen',
        name: 'successScreen',
        builder: (context, state) {
          final args = state.extra as SuccessScreenArgs;
          return SuccessScreen(args: args);
        },
      ),
      GoRoute(
        path: '/homeScreen',
        name: Routes.homeScreen.name,
       builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/navigationMenu',
        name: Routes.navigationMenu.name,
       builder: (context, state) => const NavigationMenu(),
      ),
      GoRoute(
        path: '/forgetPasswordScreen',
        name: Routes.forgetPasswordScreen.name,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: '/addressFormScreen',
        name: Routes.addressFormScreen.name,
        builder: (context, state) => const AddressFormScreen(),
      ),
      GoRoute(
        path: '/companySignupScreen',
        name: Routes.companySignupScreen.name,
        builder: (context, state) => const CompanySignupScreen(),
      ),
      GoRoute(
        path: '/uploadPortfolioScreen',
        name: Routes.uploadPortfolioScreen.name,
        builder: (context, state) => const UploadPortfolioScreen(),
      ),
      GoRoute(
        path: '/profileDetailsScreen',
        name: Routes.profileDetailsScreen.name,
        builder: (context, state) => const ProfileDetailsScreen(),
      ),
      GoRoute(
        path: '/changedPasswordScreen',
        name: Routes.changedPasswordScreen.name,
        builder: (context, state) => const ChangedPasswordScreen(),
      ),
      GoRoute(
        path: '/addEducation',
        name: Routes.addEducation.name,
        builder: (context, state) =>  AddEducation(),
      ),
      GoRoute(
        path: '/paymentsMethod',
        name: Routes.paymentsMethod.name,
        builder: (context, state) =>  PaymentsMethod(),
      ),
      GoRoute(
        path: '/preferenceScreen',
        name: Routes.preferenceScreen.name,
        builder: (context, state) =>  PreferenceScreen(),
      ),
      GoRoute(
        path: '/addSocialAccount',
        name: Routes.addSocialAccount.name,
        builder: (context, state) =>  AddSocialAccount(),
      ),
      GoRoute(
        path: '/notifcationsScreen',
        name: Routes.notifcationsScreen.name,
        builder: (context, state) =>  NotifcationsScreen(),
      ),
      GoRoute(
        path: '/bankAccountInfo',
        name: Routes.bankAccountInfo.name,
        builder: (context, state) =>  BankAccountInfo(),
      ),
      // GoRoute(

      GoRoute(
        path: '/accountSettingScreen',
        name: Routes.accountSettingScreen.name,
        builder: (context, state) => const AccountSettingScreen(),
      ),
      GoRoute(
        path: '/profileInformationScreen',
        name: Routes.profileInformationScreen.name,
        builder: (context, state) => const ProfileInformationScreen(),
      ),
      GoRoute(
        path: '/profileScreen',
        name: Routes.profileScreen.name,
        builder: (context, state) => const ProfileScreen(),
      ),

      GoRoute(
        path: '/addExperienceScreen',
        name: Routes.addExperienceScreen.name,
        builder: (context, state) => const AddExperienceScreen(),
      ),

      GoRoute(
        path: '/changeWorkExperienceScreen',
        name: Routes.changeWorkExperienceScreen.name,
        builder: (context, state) => const ChangeWorkExperienceScreen(),
      ),



      GoRoute(
        path: '/contactDetailsScreen',
        name: Routes.contactDetailsScreen.name,
        builder: (context, state) => ContactDetailsAcceptedScreen(),
      ),

      GoRoute(
        path: '/contactDetailsActiveScreen',
        name: Routes.contactDetailsActiveScreen.name,
        builder: (context, state) => ContactDetailsActiveScreen(),
      ),

      GoRoute(
        path: '/feedBackScreen',
        name: Routes.feedBackScreen.name,
        builder: (context, state) => FeedBackScreen(),
      ),
      GoRoute(
        path: '/contactSupportScreen',
        name: Routes.contactSupportScreen.name,
        builder: (context, state) => ContactSupportScreen(),
      ),
      GoRoute(
        path: '/reportScreen',
        name: Routes.reportScreen.name,
        builder: (context, state) => ReportScreen(),
      ),
      GoRoute(
        path: '/supportRequestsScreen',
        name: Routes.supportRequestsScreen.name,
        builder: (context, state) => SupportRequestsScreen(),
      ),
      GoRoute(
        path: '/membershipPlansScreen',
        name: Routes.membershipPlansScreen.name,
        builder: (context, state) => MembershipPlansScreen(),
      ),
      GoRoute(
        path: '/languageScreen',
        name: Routes.languageScreen.name,
        builder: (context, state) => LanguageScreen(),
      ),

      GoRoute(
        path: '/jobDetailScreen',
        name: Routes.jobDetailScreen.name,
        builder: (context, state) => JobDetailScreen(),
      ),
      GoRoute(
        path: '/jobDetailsPage',
        name: Routes.jobDetailsPage.name,
        builder: (context, state) => JobDetailsPage(),
      ),
      GoRoute(
        path: '/reportJobScreen',
        name: Routes.reportJobScreen.name,
        builder: (context, state) => ReportJobScreen(),
      ),
      GoRoute(
        path: '/contractDetailScreen',
        name: Routes.contractDetailScreen.name,
        builder: (context, state) {
          // Extract parameters from state.extra or state.params
          final Map<String, dynamic>? extra = state.extra as Map<String, dynamic>?;

          return ContractDetailScreen(
            status: extra?['status'] ?? 'Active', // Default to Active if not provided
            contractId: extra?['contractId'],
            name: extra?['name'],
            jobTitle: extra?['jobTitle'],
          );
        },
      ),
      GoRoute(
        path: '/chatScreen',
        name: Routes.chatScreen.name,
        builder: (context, state) => ChatScreen(),
      ),


      GoRoute(
        path: '/checkEmailScreen',
        name: Routes.checkEmailScreen.name,
        builder: (context, state) => CheckEmailScreen(),
      ),
      GoRoute(
        path: '/emailVerifiedScreen',
        name: Routes.emailVerifiedScreen.name,
        builder: (context, state) => EmailVerifiedScreen(),
      ),
      GoRoute(
        path: '/myAdsScreen',
        name: Routes.myAdsScreen.name,
        builder: (context, state) => MyAdsScreen(),
      ),
      GoRoute(
        path: '/createAdScreen',
        name: Routes.createAdScreen.name,
        builder: (context, state) => CreateAdScreen(),
      ),
      GoRoute(
        path: '/adUploadScreen',
        name: Routes.adUploadScreen.name,
        builder: (context, state) => AdUploadScreen(),
      ),
      GoRoute(
        path: '/adDetailsScreen',
        name: Routes.adDetailsScreen.name,
        builder: (context, state) => AdDetailsScreen(),
      ),
      GoRoute(
        path: '/forgetPasswordOtpScreen',
        name: Routes.forgetPasswordOtpScreen.name,
        builder: (context, state) => ForgetPasswordOtpScreen(),
      ),
      GoRoute(
        path: '/proposalScreen',
        name: Routes.proposalScreen.name,
        builder: (context, state) => ProposalScreen(),
      ),
      GoRoute(
        path: '/financeReportScreen',
        name: Routes.financeReportScreen.name,
        builder: (context, state) => FinanceReportScreen(),
      ),
      GoRoute(
        path: '/withdrawalScreen',
        name: Routes.withdrawalScreen.name,
        builder: (context, state) => WithdrawalScreen(),
      ),
      GoRoute(
        path: '/deliverContractScreen',
        name: Routes.deliverContractScreen.name,
        builder: (context, state) => DeliverContractScreen(),
      ),
      GoRoute(
        path: '/emailVerificationScreen',
        name: Routes.emailVerificationScreen.name,
        builder: (context, state) => EmailVerificationScreen(),
      ),
      GoRoute(
        path: '/contractorSignupScreen',
        name: Routes.contractorSignupScreen.name,
        builder: (context, state) => ContractorSignupScreen(),
      ),

      GoRoute(
        path: '/bottomNav',
        name: Routes.bottomNav.name,
        builder: (context, state) => const BottomNavBar(),
      )



    ],
  );
}