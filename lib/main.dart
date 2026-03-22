import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_contract_app/presentation/routes/app_routes.dart';
import 'package:job_contract_app/provider.dart' as AppProviders;
import 'package:job_contract_app/theme_controller/ThemeNotifier.dart';
import 'package:job_contract_app/theme_controller/theme_pref_helper.dart';
import 'package:job_contract_app/utils/constants/colors.dart';
import 'package:job_contract_app/utils/themes/themes.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import 'config/dependencies/src/InjectionContainer.dart';
import 'core/constants/api_endpoints.dart';
import 'core/network/api_client.dart';
import 'core/services/auth_service.dart';
import 'data/data_source/local/AuthPreferences.dart';

// ✅ Global variable to store initial route
String? globalInitialRoute;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await EasyLocalization.ensureInitialized();

  // ── Initialize DI ─────────────────────────────────────────────────────────
  await injectionContainer.init();


  // ── Check saved session (token + user) ────────────────────────────────────
  final apiClient = ApiClient(ApiPath.baseUrl);
  try {
    final isLoggedIn = await AuthPreferences.isLoggedIn();

    if (isLoggedIn) {
      final token = await AuthPreferences.getToken();
      final user  = await AuthPreferences.getUser();

      // Restore token to ApiClient for outgoing requests
      if (token != null) await apiClient.saveToken(token);

      debugPrint('✅ Session restored:');
      debugPrint('   email:    ${user?.email}');
      debugPrint('   userType: ${user?.userType}');
      debugPrint('   token:    ${token?.substring(0, 20)}...');

      globalInitialRoute = '/navigationMenu';
    } else {
      debugPrint('❌ No session found — redirecting to onboarding');
      globalInitialRoute = '/onboardingScreen';
    }
  } catch (e) {
    debugPrint('❌ Error restoring session: $e');
    globalInitialRoute = '/onboardingScreen';
  }

  debugPrint('📍 Initial route: $globalInitialRoute');

  // ── Theme ─────────────────────────────────────────────────────────────────
  final isDarkMode = await ThemePrefHelper.loadThemeMode();

  // ── Splash ────────────────────────────────────────────────────────────────
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('es', 'ES')],
      path: 'assets/languages',
      fallbackLocale: const Locale('es', 'ES'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ThemeNotifier()..toggleTheme(isDarkMode ?? false),
          ),
          ...AppProviders.getProviders(),
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
            routerConfig: AppRouter.router,
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