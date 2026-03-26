//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:job_contract_app/presentation/routes/app_routes.dart';
// import 'package:job_contract_app/provider.dart';
// import 'package:job_contract_app/theme_controller/ThemeNotifier.dart';
// import 'package:job_contract_app/theme_controller/theme_pref_helper.dart';
// import 'package:job_contract_app/utils/constants/colors.dart';
// import 'package:job_contract_app/utils/themes/themes.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:provider/provider.dart';
//
// import 'config/dependencies/SocketService.dart';
// import 'config/dependencies/src/InjectionContainer.dart';
// import 'data/data_source/local/AuthPreferences.dart';
// import 'presentation/features/users/providers/user_provider.dart';
//
// // ✅ Holds the resolved initial route — set before runApp()
// String globalInitialRoute = '/onboardingScreen';
//
// Future<void> main() async {
//   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//
//   await EasyLocalization.ensureInitialized();
//
//   // ── 1. Initialize DI container ──────────────────────────────────────────
//   await injectionContainer.init();
//
//   // ── 2. Create UserProvider early (before runApp) ────────────────────────
//   //    We instantiate it here so we can call getMe() and pass the already-
//   //    hydrated instance into MultiProvider via .value constructor.
//   final userProvider = UserProvider();
//
//   // ── 3. Check session & fetch user data ──────────────────────────────────
//   try {
//     final isLoggedIn = await AuthPreferences.isLoggedIn();
//
//     if (isLoggedIn) {
//       final token = await AuthPreferences.getToken();
//
//       // Connect socket with restored token
//       if (token != null) SocketService().connect(token);
//
//       // ✅ Fetch fresh user profile from API
//       await userProvider.getMe();
//
//       if (userProvider.currentUser != null) {
//         // ✅ Store fresh data back into local storage
//         final token = await AuthPreferences.getToken();
//         await AuthPreferences.saveSession(
//           token: token ?? '',
//           user: userProvider.currentUser!,
//         );
//
//         globalInitialRoute = '/navigationMenu';
//         debugPrint('✅ User fetched & stored: ${userProvider.currentUser?.email}');
//       }
//       else {
//         await AuthPreferences.clearSession();
//         globalInitialRoute = '/onboardingScreen';
//         debugPrint('⚠️ getMe() returned null — clearing session, redirecting');
//       }
//     } else {
//       debugPrint('❌ No session — redirecting to onboarding');
//       globalInitialRoute = '/onboardingScreen';
//     }
//   } catch (e) {
//     debugPrint('❌ Error during session restore: $e');
//     await AuthPreferences.clearSession();
//     globalInitialRoute = '/onboardingScreen';
//   }
//   // // ── 3. Check session & fetch user data ──────────────────────────────────
//   // try {
//   //   final isLoggedIn = await AuthPreferences.isLoggedIn();
//   //
//   //   if (isLoggedIn) {
//   //     final token = await AuthPreferences.getToken();
//   //     final user  = await AuthPreferences.getUser();
//   //
//   //     debugPrint('✅ Session restored:');
//   //     debugPrint('   email:    ${user?.email}');
//   //     debugPrint('   userType: ${user?.userType}');
//   //     debugPrint('   token:    ${token?.substring(0, 20)}...');
//   //
//   //     // Connect socket with restored token
//   //     if (token != null) SocketService().connect(token);
//   //
//   //     // ✅ Fetch fresh user profile from API → stored in userProvider.currentUser
//   //     await userProvider.getMe();
//   //
//   //     if (userProvider.currentUser != null) {
//   //       // User fetched successfully → go to main app
//   //       globalInitialRoute = '/navigationMenu';
//   //       debugPrint('✅ User fetched: ${userProvider.currentUser?.email}');
//   //     } else {
//   //       // Token exists but API call failed (expired / server error) → re-login
//   //       globalInitialRoute = '/onboardingScreen';
//   //       debugPrint('⚠️ Token found but getMe() failed — redirecting to onboarding');
//   //     }
//   //   } else {
//   //     debugPrint('❌ No session — redirecting to onboarding');
//   //     globalInitialRoute = '/onboardingScreen';
//   //   }
//   // } catch (e) {
//   //   debugPrint('❌ Error during session restore: $e');
//   //   globalInitialRoute = '/onboardingScreen';
//   // }
//
//   debugPrint('📍 Initial route: $globalInitialRoute');
//
//   // ── 4. Load theme preference ─────────────────────────────────────────────
//   final isDarkMode = await ThemePrefHelper.loadThemeMode();
//
//   // ── 5. Remove splash screen ──────────────────────────────────────────────
//   await Future.delayed(const Duration(seconds: 3));
//   FlutterNativeSplash.remove();
//
//   // ── 6. Run app ───────────────────────────────────────────────────────────
//   runApp(
//     EasyLocalization(
//       supportedLocales: const [Locale('en', 'US'), Locale('es', 'ES')],
//       path: 'assets/languages',
//       fallbackLocale: const Locale('es', 'ES'),
//       child: MultiProvider(
//         providers: [
//
//           // Theme provider
//           ChangeNotifierProvider(
//             create: (_) => ThemeNotifier()..toggleTheme(isDarkMode ?? false),
//           ),
//
//           // ✅ All app providers — userProvider passed in (already has currentUser)
//           ...getProviders(userProvider: userProvider),
//
//         ],
//         child: const JobContractsApp(),
//       ),
//     ),
//   );
// }
//
// // ════════════════════════════════════════════════════════════════════════════
// // App Widget
// // ════════════════════════════════════════════════════════════════════════════
//
// class JobContractsApp extends StatelessWidget {
//   const JobContractsApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(375, 812),
//       minTextAdapt: true,
//       child: Consumer<ThemeNotifier>(
//         builder: (context, themeNotifier, _) {
//           return MaterialApp.router(
//             debugShowCheckedModeBanner: false,
//
//             // ✅ Router reads globalInitialRoute to decide the first screen.
//             // Make sure your AppRouter.router uses globalInitialRoute
//             // as the initialLocation — see note at bottom of file.
//             routerConfig: AppRouter.router,
//
//             theme: _updateThemeWithStatusBar(JAppTheme.lightTheme, false),
//             darkTheme: _updateThemeWithStatusBar(JAppTheme.darkTheme, true),
//             themeMode: themeNotifier.themeMode,
//             localizationsDelegates: context.localizationDelegates,
//             supportedLocales: context.supportedLocales,
//             locale: context.locale,
//             builder: (context, child) {
//               _updateStatusBarBasedOnTheme(context);
//               return LoaderOverlay(child: child!);
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   void _updateStatusBarBasedOnTheme(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
//       statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
//       systemNavigationBarColor:
//       isDark ? JAppColors.darkGray800 : Colors.white,
//       systemNavigationBarIconBrightness:
//       isDark ? Brightness.light : Brightness.dark,
//     ));
//   }
//
//   ThemeData _updateThemeWithStatusBar(ThemeData theme, bool isDark) {
//     return theme.copyWith(
//       appBarTheme: theme.appBarTheme.copyWith(
//         systemOverlayStyle: SystemUiOverlayStyle(
//           statusBarColor: Colors.transparent,
//           statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
//           statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
//         ),
//       ),
//     );
//   }
// }



import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_contract_app/presentation/features/users/providers/auth_provider.dart';
import 'package:job_contract_app/presentation/routes/app_routes.dart';
import 'package:job_contract_app/provider.dart';
import 'package:job_contract_app/theme_controller/ThemeNotifier.dart';
import 'package:job_contract_app/theme_controller/theme_pref_helper.dart';
import 'package:job_contract_app/utils/constants/colors.dart';
import 'package:job_contract_app/utils/themes/themes.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import 'config/dependencies/SocketService.dart';
import 'config/dependencies/src/InjectionContainer.dart';
import 'data/data_source/local/AuthPreferences.dart';
import 'presentation/features/users/providers/user_provider.dart';

// ✅ Holds the resolved initial route — set before runApp()
String globalInitialRoute = '/onboardingScreen';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await EasyLocalization.ensureInitialized();

  // ── 1. Initialize DI container ──────────────────────────────────────────
  await injectionContainer.init();

  // ── 2. Create UserProvider early (before runApp) ────────────────────────
  final userProvider = AuthProvider();

  // ── 3. Check session & fetch user data ──────────────────────────────────
  try {
    final isLoggedIn = await AuthPreferences.isLoggedIn();

    if (isLoggedIn) {
      final token = await AuthPreferences.getToken(); // ✅ declared once

      // Connect socket with restored token
      if (token != null) SocketService().connect(token);

      // Fetch fresh user profile from API
      await userProvider.getMe();

      if (userProvider.currentUser != null) {
        // ✅ Store fresh data back into local storage
        await AuthPreferences.saveSession(
          token: token ?? '',
          user: userProvider.currentUser!,
        );

        globalInitialRoute = '/navigationMenu'; // ✅ go to main app
        debugPrint('✅ User fetched & stored: ${userProvider.currentUser?.email}');
      } else {
        // Token exists but API rejected it → clear & re-login
        await AuthPreferences.clearSession();
        globalInitialRoute = '/onboardingScreen';
        debugPrint('⚠️ getMe() returned null — clearing session, redirecting');
      }
    } else {
      debugPrint('❌ No session — redirecting to onboarding');
      globalInitialRoute = '/onboardingScreen';
    }
  } catch (e) {
    debugPrint('❌ Error during session restore: $e');
    await AuthPreferences.clearSession();
    globalInitialRoute = '/onboardingScreen';
  }

  debugPrint('📍 Initial route: $globalInitialRoute');

  // ── 4. Load theme preference ─────────────────────────────────────────────
  final isDarkMode = await ThemePrefHelper.loadThemeMode();

  // ── 5. Remove splash screen ──────────────────────────────────────────────
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();

  // ── 6. Run app ───────────────────────────────────────────────────────────
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('es', 'ES')],
      path: 'assets/languages',
      fallbackLocale: const Locale('es', 'ES'),
      child: MultiProvider(
        providers: [
          // Theme provider
          ChangeNotifierProvider(
            create: (_) => ThemeNotifier()..toggleTheme(isDarkMode ?? false),
          ),

          // ✅ All app providers — userProvider passed in (already has currentUser)
          ...getProviders(userProvider: userProvider),
        ],
        child: const JobContractsApp(),
      ),
    ),
  );
}

class JobContractsApp extends StatelessWidget {
  const JobContractsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, _) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router, // ✅ lazy — reads globalInitialRoute correctly
            theme: _updateThemeWithStatusBar(JAppTheme.lightTheme, false),
            darkTheme: _updateThemeWithStatusBar(JAppTheme.darkTheme, true),
            themeMode: themeNotifier.themeMode,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            builder: (context, child) {
              _updateStatusBarBasedOnTheme(context);
              return LoaderOverlay(child: child!);
            },
          );
        },
      ),
    );
  }

  void _updateStatusBarBasedOnTheme(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: isDark ? JAppColors.darkGray800 : Colors.white,
      systemNavigationBarIconBrightness:
      isDark ? Brightness.light : Brightness.dark,
    ));
  }

  ThemeData _updateThemeWithStatusBar(ThemeData theme, bool isDark) {
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        ),
      ),
    );
  }
}