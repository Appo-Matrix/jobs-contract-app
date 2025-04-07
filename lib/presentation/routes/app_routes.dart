import 'package:go_router/go_router.dart';
import 'package:job_contracts/core/constants/global.dart';
import 'package:job_contracts/presentation/features/auth/screens/forget_password/forget_password_screen.dart';
import 'package:job_contracts/presentation/features/auth/screens/onboarding/onboarding_screen.dart';
import 'package:job_contracts/presentation/features/users/screen/account_screen/add_experiance_screen.dart';
import 'package:job_contracts/presentation/features/users/screen/account_screen/change_work_experience_screen.dart';
import 'package:job_contracts/presentation/routes/routes.dart';

import '../features/auth/screens/Login/login_screen.dart';
import '../features/auth/screens/address_form/address_form_screen.dart';
import '../features/auth/screens/portfilo_screen/upload_portfolio_screen.dart';
import '../features/auth/screens/profile/profile_detail.dart';
import '../features/auth/screens/reset_password/reset_password.dart';
import '../features/auth/screens/sign_up_type/account_creation_screen.dart';
import '../features/auth/screens/signup/signup_screen.dart';
import '../features/auth/screens/specilization/specialization_screen.dart';
import '../features/auth/screens/terms_condition_screen/terms_conditionsS_screen.dart';
import '../features/auth/screens/verify_profile/screens/success_screen.dart';
import '../features/auth/screens/verify_profile/screens/verify_identity.dart';
import '../features/auth/screens/verify_profile/screens/verify_payment_method.dart';
import '../features/auth/screens/verify_profile/screens/verify_phone_number.dart';
import '../features/auth/screens/otp/verify_phone_otp.dart';
import '../features/auth/screens/verify_profile/screens/verify_profile.dart';
import '../features/auth/verification_screen/verification_screen.dart';
import '../features/users/NavigationMenu.dart';
import '../features/users/bank_account_info/bank_account_info.dart';
import '../features/users/contract/contract_detail/contract_detail_screen.dart';
import '../features/users/home/home_screen.dart';
import '../features/users/home/job_details/JobDetailScreen.dart';
import '../features/users/home/job_details/job_detail_page.dart';
import '../features/users/home/job_details/report_job_screen.dart';
import '../features/users/language/language_detail_screen.dart';
import '../features/users/language/language_screen.dart';
import '../features/users/language/language_selection_screen.dart';
import '../features/users/message/chat_screen.dart';
import '../features/users/payments/payments_method.dart';
import '../features/users/profile/profile_detail.dart';
import '../features/users/reports/contact_support.dart';
import '../features/users/reports/reports_screen.dart';
import '../features/users/reports/support_request.dart';
import '../features/users/screen/account_screen/account_setting_screen.dart';
import '../features/users/screen/account_screen/changed_password_screen.dart';
import '../features/users/screen/account_screen/preference_screen.dart';
import '../features/users/screen/account_screen/profile_information_screen.dart';
import '../features/users/add_education/add_education.dart';
import '../features/users/add_social_account/add_social_account.dart';
import '../features/users/notification/notifcations.dart';
import '../features/users/screen/contact_detail_screens/contact_details_accepted_screen.dart';
import '../features/users/screen/contact_detail_screens/contact_details_active_screen.dart';
import '../features/users/screen/contact_detail_screens/feed_back_screen.dart';
import '../features/users/upgrade/membership_plans_screen.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    // initialLocation: '/onboardingScreen',
    initialLocation: '/onboardingScreen',
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
        path: '/accountCreationScreen',
        name: Routes.accountCreationScreen.name,
       builder: (context, state) => const AccountCreationScreen(),
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
        path: '/successScreen',
        name: Routes.successScreen.name,
       builder: (context, state) => const SuccessScreen(),
      ),
      GoRoute(
        path: '/verifyIdentity',
        name: Routes.verifyIdentity.name,
       builder: (context, state) => const VerifyIdentity(),
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
        path: '/termsConditionsScreen',
        name: Routes.termsConditionsScreen.name,
        builder: (context, state) => const TermsConditionsScreen(),
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
        path: '/languageSelectionScreen',
        name: Routes.languageSelectionScreen.name,
        builder: (context, state) => LanguageSelectionScreen(),
      ),
      GoRoute(
        path: '/languageDetailScreen',
        name: Routes.languageDetailScreen.name,
        builder: (context, state) => LanguageDetailScreen(),
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
        builder: (context, state) => ContractDetailScreen(),
      ),
      GoRoute(
        path: '/chatScreen',
        name: Routes.chatScreen.name,
        builder: (context, state) => ChatScreen(),
      ),
      GoRoute(
        path: '/specializationScreen',
        name: Routes.specializationScreen.name,
        builder: (context, state) => SpecializationScreen(),
      ),
      GoRoute(
        path: '/verificationScreen',
        name: Routes.verificationScreen.name,
        builder: (context, state) => VerificationScreen(),
      ),

    ],
  );
}