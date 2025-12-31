import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:job_contracts/config/app_config.dart';
import 'package:job_contracts/core/constants/api_endpoints.dart';
import 'package:job_contracts/core/constants/keys/secure_storage_keys.dart';
import 'package:job_contracts/core/network/api_client.dart';
import 'package:job_contracts/domain/services/secure_storage_service.dart';
import 'package:job_contracts/presentation/features/auth/providers/auth_provider.dart';
import 'package:job_contracts/presentation/features/auth/providers/register_provider.dart';
import 'package:job_contracts/presentation/features/users/providers/ad_provider.dart';
import 'package:job_contracts/presentation/features/users/providers/application_provider.dart';
import 'package:job_contracts/presentation/features/users/providers/contract_provider.dart';
import 'package:job_contracts/presentation/features/users/providers/current_user_provider.dart';
import 'package:job_contracts/presentation/features/users/providers/job_provider.dart';
import 'package:job_contracts/presentation/global_notifiers/register_notifiers.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/theme_controller/ThemeNotifier.dart';
import 'package:job_contracts/theme_controller/theme_pref_helper.dart';
import 'package:job_contracts/utils/themes/themes.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import 'config/dependencies/src/notifiers_di.dart';
import 'core/constants/global.dart';

final Dio dio = Dio(BaseOptions(
  baseUrl: 'http://arquimatch.eu-4.evennode.com',
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 3),
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
));

// ✅ Global variable to store initial route
String? globalInitialRoute;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await EasyLocalization.ensureInitialized();

  // Initialize app-level configuration
  AppConfig().initialize();

  // ✅ Check for saved token BEFORE building the app
  final apiClient = ApiClient(ApiPath.baseUrl);
  try {
    final token = await SecureStorageService.get(SecureStorageKeys.authToken);

    if (token != null && token.isNotEmpty) {
      debugPrint("✅ Token found during startup: ${token.substring(0, 10)}...");
      await apiClient.saveToken(token);
      globalInitialRoute = '/navigationMenu';
    } else {
      debugPrint("❌ No token found during startup");
      globalInitialRoute = '/onboardingScreen';
    }
  } catch (e) {
    debugPrint("❌ Error checking token: $e");
    globalInitialRoute = '/onboardingScreen';
  }

  debugPrint("📍 Global initial route set to: $globalInitialRoute");

  // Register providers
  getIt.registerLazySingleton<AuthProvider>(() => AuthProvider());
  getIt.registerLazySingleton<RegisterProvider>(() => RegisterProvider());
  getIt.registerLazySingleton<JobProvider>(() => JobProvider());
  getIt.registerLazySingleton<ContractProvider>(() => ContractProvider());
  getIt.registerLazySingleton<ApplicationProvider>(() => ApplicationProvider());
  getIt.registerLazySingleton<AdProvider>(() => AdProvider());
  getIt.registerLazySingleton<CurrentUserProvider>(() => CurrentUserProvider());

  registerNotifiersDi();

  final isDarkMode = await ThemePrefHelper.loadThemeMode();

  // Show splash for 3 seconds
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
          ...registerGlobalNotifiers(),
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
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
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



// import 'package:dio/dio.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:job_contracts/config/app_config.dart';
// import 'package:job_contracts/core/constants/api_endpoints.dart';
// import 'package:job_contracts/core/constants/keys/secure_storage_keys.dart';
// import 'package:job_contracts/core/network/api_client.dart';
// import 'package:job_contracts/domain/services/secure_storage_service.dart';
// import 'package:job_contracts/presentation/features/auth/providers/auth_provider.dart';
// import 'package:job_contracts/presentation/features/auth/providers/register_provider.dart';
// import 'package:job_contracts/presentation/features/users/providers/job_provider.dart';
// import 'package:job_contracts/presentation/global_notifiers/register_notifiers.dart';
// import 'package:job_contracts/presentation/routes/app_routes.dart';
// import 'package:job_contracts/theme_controller/ThemeNotifier.dart';
// import 'package:job_contracts/theme_controller/theme_pref_helper.dart';
// import 'package:job_contracts/utils/themes/themes.dart';
// import 'package:job_contracts/utils/constants/colors.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:provider/provider.dart';
//
// import 'config/dependencies/src/notifiers_di.dart';
// import 'core/constants/global.dart';
//
// final Dio dio = Dio(BaseOptions(
//   baseUrl: 'http://arquimatch.eu-4.evennode.com',
//   connectTimeout: const Duration(seconds: 5),
//   receiveTimeout: const Duration(seconds: 3),
//   headers: {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//   },
// ));
//
// Future<void> main() async {
//   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//
//   await EasyLocalization.ensureInitialized();
//
//   // Initialize app-level configuration
//   AppConfig().initialize();
//
//   // ✅ Register AuthProvider before notifiers
//   getIt.registerLazySingleton<AuthProvider>(() => AuthProvider());
//   getIt.registerLazySingleton<RegisterProvider>(() => RegisterProvider());
//   getIt.registerLazySingleton<JobProvider>(() => JobProvider());
//
//   // Now it's safe
//   registerNotifiersDi();
//
//   final isDarkMode = await ThemePrefHelper.loadThemeMode();
//
//   runApp(
//     EasyLocalization(
//       supportedLocales: const [Locale('en', 'US'), Locale('es', 'ES')],
//       path: 'assets/languages',
//       fallbackLocale: const Locale('es', 'ES'),
//       child: MultiProvider(
//         providers: [
//           ChangeNotifierProvider(
//             create: (_) => ThemeNotifier()..toggleTheme(isDarkMode ?? false),
//           ),
//           ...registerGlobalNotifiers(),
//         ],
//         child: const JobContractsApp(),
//       ),
//     ),
//   );
// }
//
// class JobContractsApp extends StatefulWidget {
//   const JobContractsApp({super.key});
//
//   @override
//   State<JobContractsApp> createState() => _JobContractsState();
// }
//
// class _JobContractsState extends State<JobContractsApp> {
//   String? _initialRoute;
//   late ApiClient _apiClient;
//
//   @override
//   void initState() {
//     super.initState();
//     _apiClient = ApiClient(ApiPath.baseUrl);
//     initialization();
//   }
//
//   void initialization() async {
//     debugPrint("⏳ Initializing app...");
//
//     try {
//       // ✅ FIXED: Use authToken (matching AuthProvider)
//       final token = await SecureStorageService.get(SecureStorageKeys.authToken);
//
//       if (token != null && token.isNotEmpty) {
//         debugPrint("✅ Token found: ${token.substring(0, 10)}...");
//
//         // Save token to ApiClient for API requests
//         await _apiClient.saveToken(token);
//         debugPrint("✅ Token synced to ApiClient");
//
//         setState(() {
//           _initialRoute = '/navigationMenu';
//         });
//       } else {
//         debugPrint("❌ No token found");
//         setState(() {
//           _initialRoute = '/onboarding';
//         });
//       }
//     } catch (e) {
//       debugPrint("❌ Error during initialization: $e");
//       setState(() {
//         _initialRoute = '/onboarding';
//       });
//     }
//
//     debugPrint("📍 Initial route: $_initialRoute");
//
//     await Future.delayed(const Duration(seconds: 3));
//     FlutterNativeSplash.remove();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Show loading while determining route
//     if (_initialRoute == null) {
//       return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           backgroundColor: JAppColors.main,
//           body: const Center(
//             child: CircularProgressIndicator(
//               color: Colors.white,
//             ),
//           ),
//         ),
//       );
//     }
//
//     return ScreenUtilInit(
//       designSize: const Size(375, 812),
//       minTextAdapt: true,
//       child: Consumer<ThemeNotifier>(
//         builder: (context, themeNotifier, _) {
//           return MaterialApp.router(
//             debugShowCheckedModeBanner: false,
//             routerConfig: AppRouter.router,
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
//       systemNavigationBarColor: isDark ? JAppColors.darkGray800 : Colors.white,
//       systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
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
