import 'package:go_router/go_router.dart';
import 'package:job_contracts/core/constants/global.dart';
import 'package:job_contracts/presentation/features/auth/screens/forget_password_screen.dart';
import 'package:job_contracts/presentation/features/auth/screens/onboarding/onboarding_screen.dart';
import 'package:job_contracts/presentation/features/auth/screens/forget_password_screen.dart';
import 'package:job_contracts/presentation/features/auth/screens/reset_password.dart';
import 'package:job_contracts/presentation/routes/routes.dart';

import '../features/auth/screens/verify_profile/screens/success_screen.dart';
import '../features/auth/screens/verify_profile/screens/verify_identity.dart';
import '../features/auth/screens/verify_profile/screens/verify_payment_method.dart';
import '../features/auth/screens/verify_profile/screens/verify_phone_number.dart';
import '../features/auth/screens/verify_profile/screens/verify_phone_otp.dart';
import '../features/auth/screens/verify_profile/screens/verify_profile.dart';


class AppRouter {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/forgetPasswordScreen',

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
      )


    ],
  );
}