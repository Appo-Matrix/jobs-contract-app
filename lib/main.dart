
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_contracts/config/app_config.dart';
import 'package:job_contracts/config/dependencies/di.dart';
import 'package:job_contracts/core/constants/api_endpoints.dart';
import 'package:job_contracts/core/network/api_client.dart';
import 'package:job_contracts/presentation/global_notifiers/register_notifiers.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/theme_controller/ThemeNotifier.dart';
import 'package:job_contracts/theme_controller/theme_pref_helper.dart';
import 'package:job_contracts/utils/themes/themes.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';


final Dio dio = Dio(BaseOptions(
  baseUrl: 'http://arquimatch.eu-4.evennode.com',
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 3),
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
));
  void main() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    //
    // ApiClient apiClient = ApiClient(ApiPath.baseUrl);
    //
    // apiClient.get('/auth/register');
    // ApiClient(ApiPath.baseUrl);
    
    
    // bool isApiAvailable = await checkApiConnectivity();
    // print("API connectivity: ${isApiAvailable ? "Available" : "Unavailable"}");
    try {
      print("Attempting to load localization files from: assets/languages/");
      await EasyLocalization.ensureInitialized();
      print("Localization initialized successfully");

      registerNotifiersDi();
      AppConfig().initialize();

      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      final isDark = brightness == Brightness.dark;

      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: isDark ? JAppColors.darkGray800 : Colors.white,
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ));

      runApp(
        EasyLocalization(
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('es', 'ES'),
          ],
          path: 'assets/languages',

          fallbackLocale: const Locale('es', 'ES'),
          child: await createAppWithTheme(),
        ),
      );
    } catch (e, stackTrace) {
      print("Error during initialization: $e");
      print("Stack trace: $stackTrace");

      // Still run the app even if localization fails
      runApp(await createAppWithTheme());
    }
  }
// Future<bool> checkApiConnectivity() async {
//   try {
//     // Updated to use /api-docs endpoint which is visible in the screenshot
//     final response = await dio.get('/api-docs');
//     return response.statusCode == 200;
//   } catch (e) {
//     // Try alternative endpoint if the first one fails
//     try {
//       final response = await dio.get('/admin-auth/profile');
//       return response.statusCode == 200;
//     } catch (e) {
//       print("API connectivity check failed: $e");
//       return false;
//     }
//   }
// }
  Future<Widget> createAppWithTheme() async {
    final isDark = await ThemePrefHelper.loadThemeMode();

    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier()..toggleTheme(isDark ?? false),
      child: const JobContractsApp(),
    );
  }

  class JobContractsApp extends StatefulWidget {
    const JobContractsApp({super.key});

    @override
    State<JobContractsApp> createState() => _JobContractsState();
  }

  class _JobContractsState extends State<JobContractsApp> {

    @override
    void initState() {
      super.initState();
      initialization();

    }



    void initialization() async {
      debugPrint("pausing...");
      await Future.delayed(const Duration(seconds: 3));
      debugPrint("unpausing");
      FlutterNativeSplash.remove();
    }

    @override
    Widget build(BuildContext context) {
      return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: MultiProvider(
          providers: registerGlobalNotifiers(),
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

