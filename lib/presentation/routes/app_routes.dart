import 'package:go_router/go_router.dart';
import 'package:job_contracts/core/constants/global.dart';
import 'package:job_contracts/presentation/routes/routes.dart';


class AppRouter {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    // initialLocation: '/bottomNamvBar',
    initialLocation: '/splashScreen',

    routes: [
      GoRoute(
        path: '/splashScreen',
        name: Routes.splash.name,
      //  builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/startScreen',
        name: Routes.startScreen.name,
      //  builder: (context, state) => const StartScreen(),
      ),

    ],
  );
}