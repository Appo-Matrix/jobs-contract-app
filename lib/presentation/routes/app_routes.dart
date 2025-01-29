import 'package:go_router/go_router.dart';
import 'package:job_contracts/core/constants/global.dart';
import 'package:job_contracts/presentation/features/auth/screens/forget_password_screen.dart';
import 'package:job_contracts/presentation/features/auth/screens/onboarding/onboarding_screen.dart';
import 'package:job_contracts/presentation/features/auth/screens/forget_password_screen.dart';
import 'package:job_contracts/presentation/routes/routes.dart';


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
        path: '/forgetPasswordScreen',
        name: Routes.forgetPasswordScreen.name,
       builder: (context, state) => const ForgetPasswordScreen(),
      ),


    ],
  );
}