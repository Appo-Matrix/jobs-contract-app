import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:job_contracts/core/constants/global.dart';
import 'package:job_contracts/presentation/features/auth/screens/forget_password_screen.dart';
import 'package:job_contracts/presentation/features/auth/screens/onboarding/onboarding_screen.dart';
import 'package:job_contracts/presentation/features/auth/screens/forget_password_screen.dart';
import 'package:job_contracts/presentation/features/auth/screens/reset_password.dart';
import 'package:job_contracts/presentation/features/users/bank_account_info/bank_account_info.dart';
import 'package:job_contracts/presentation/features/users/payments/payments_method.dart';
import 'package:job_contracts/presentation/routes/routes.dart';

import '../features/auth/screens/verify_profile/screens/success_screen.dart';
import '../features/auth/screens/verify_profile/screens/verify_identity.dart';
import '../features/auth/screens/verify_profile/screens/verify_payment_method.dart';
import '../features/auth/screens/verify_profile/screens/verify_phone_number.dart';
import '../features/auth/screens/verify_profile/screens/verify_phone_otp.dart';
import '../features/auth/screens/verify_profile/screens/verify_profile.dart';
import '../features/users/add_education/add_education.dart';
import '../features/users/add_social_account/add_social_account.dart';
import '../features/users/notification/notifcations.dart';


class AppRouter {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/bankAccountInfo',

    routes: [
      // User
      GoRoute(
        path: '/onboardingScreen',
        name: Routes.onboardingScreen.name,
       builder: (context, state) => const OnboardingScreen(),
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
        path: '/forgetPasswordScreen',
        name: Routes.forgetPasswordScreen.name,
        builder: (context, state) => const ForgetPasswordScreen(),
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
      //   path: '/bankAccountInfo',
      //   name: Routes.bankAccountInfo.name,
      //   builder: (context, state) =>  BankAccountInfo(),
      // ),


    ],
  );
}