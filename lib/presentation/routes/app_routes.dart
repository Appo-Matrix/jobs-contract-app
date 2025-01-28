import 'package:go_router/go_router.dart';
import 'package:job_contracts/core/constants/global.dart';
import 'package:job_contracts/presentation/features/auth/screens/onboarding_screen.dart';
import 'package:job_contracts/presentation/routes/routes.dart';


class AppRouter {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/homeScreen',

    routes: [
      // User
      GoRoute(
        path: '/OnboardingScreen',
        name: Routes.OnboardingScreen.name,
       builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/homeScreen',
        name: Routes.homeScreen.name,
        builder: (context, state) => const OnboardingScreen(),
      ),

    ],
  );
}