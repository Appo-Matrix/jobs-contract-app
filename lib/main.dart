import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:job_contract_app/presentation/features/auth/providers/auth_provider.dart';
import 'package:job_contract_app/presentation/features/auth/providers/register_provider.dart';
import 'package:job_contract_app/presentation/features/users/account_screen/provider/change_password_provider.dart';
import 'package:job_contract_app/presentation/features/users/account_screen/provider/recent_job_provider.dart';
import 'package:job_contract_app/presentation/features/users/account_screen/repos/change_password_repository.dart';
import 'package:job_contract_app/presentation/features/users/account_screen/repos/change_password_repository_impl.dart';
import 'package:job_contract_app/presentation/features/users/blog/provider/blog_provider.dart';
import 'package:job_contract_app/presentation/features/users/blog/repo/blog_repository.dart';
import 'package:job_contract_app/presentation/features/users/blog/repo/blog_repository_impl.dart';
import 'package:job_contract_app/presentation/features/users/home/job_details/provider/job_application_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/ad_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/application_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/contract_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/current_user_provider.dart';
import 'package:job_contract_app/presentation/features/users/providers/job_provider.dart';

// ✅ ADD THIS IMPORT — adjust the path to match your project structure
import 'package:job_contract_app/presentation/global_notifiers/register_notifiers.dart';
import 'package:job_contract_app/presentation/routes/app_routes.dart';
import 'package:job_contract_app/theme_controller/ThemeNotifier.dart';
import 'package:job_contract_app/theme_controller/theme_pref_helper.dart';
import 'package:job_contract_app/utils/constants/colors.dart';
import 'package:job_contract_app/utils/themes/themes.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import 'config/app_config.dart';
import 'config/dependencies/src/notifiers_di.dart';
import 'core/constants/api_endpoints.dart';
import 'core/constants/global.dart';
import 'core/constants/keys/secure_storage_keys.dart';
import 'core/network/api_client.dart';
import 'core/services/auth_service.dart';
import 'domain/services/secure_storage_service.dart';

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
  final authService = AuthService();
  await authService.init();
  debugPrint('✅ AuthService initialized');

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

  final BlogRepository blogRepository = BlogRepositoryImpl(dio);
  final blogProvider = BlogProvider(blogRepository, authService);

  // ── ChangePassword DI ────────────────────────────────────────────────────
  final ChangePasswordRepository changePasswordRepository =
  ChangePasswordRepositoryImpl(
    dio: dio,
    updatePasswordEndpoint: ApiPath.updatePassword,
  );

  // ── Register providers ───────────────────────────────────────────────────
  getIt.registerLazySingleton<AuthProvider>(() => AuthProvider());
  getIt.registerLazySingleton<RegisterProvider>(() => RegisterProvider());
  getIt.registerLazySingleton<JobProvider>(() => JobProvider());
  getIt.registerLazySingleton<ContractProvider>(() => ContractProvider());
  getIt.registerLazySingleton<ApplicationProvider>(() => ApplicationProvider());
  getIt.registerLazySingleton<AdProvider>(() => AdProvider());
  getIt.registerLazySingleton<CurrentUserProvider>(() => CurrentUserProvider());
  getIt.registerLazySingleton<BlogProvider>(() => blogProvider);
  getIt.registerLazySingleton<JobApplicationProvider>(
          () => JobApplicationProvider());
  getIt.registerLazySingleton<ChangePasswordRepository>(
          () => changePasswordRepository);
  getIt.registerLazySingleton<ChangePasswordProvider>(
          () => ChangePasswordProvider(getIt<ChangePasswordRepository>()));

  // ✅ ADD THIS — register RecentJobProvider the same way as other providers
  getIt.registerLazySingleton<RecentJobProvider>(() => RecentJobProvider());

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
          // ✅ ChangePasswordProvider added to the widget tree
          ChangeNotifierProvider<ChangePasswordProvider>(
            create: (_) => getIt<ChangePasswordProvider>(),
          ),
          // ✅ ADD THIS — expose RecentJobProvider to the widget tree
          ChangeNotifierProvider<RecentJobProvider>(
            create: (_) => getIt<RecentJobProvider>(),
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