import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_contracts/config/app_config.dart';
import 'package:job_contracts/config/dependencies/di.dart';
import 'package:job_contracts/domain/services/app_services.dart';
import 'package:job_contracts/presentation/features/auth/screens/onboarding/onboarding_screen.dart';
import 'package:job_contracts/presentation/features/auth/screens/verify_profile/screens/verify_phone_number.dart';
import 'package:job_contracts/presentation/global_notifiers/register_notifiers.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/themes/themes.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  AppServices.initialize();
  registerNotifiersDi();
  AppConfig().initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 3));

  runApp(const JobContractsApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const VerifyPhoneNumber(),
    );
  }
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
    FlutterNativeSplash.remove(); // This must be called!
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MultiProvider(

        providers: registerGlobalNotifiers(),
        child: MaterialApp.router(
          // theme: ,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          theme: JAppTheme.lightTheme,  // Apply your custom light theme
          darkTheme: JAppTheme.darkTheme,  // Apply your custom dark theme
          themeMode: ThemeMode.system,
          builder: (context, child) {
            return LoaderOverlay(
              overlayWidgetBuilder: (_) {
                return const Center(
                  // child: CircularProgressIndicator(color: PColors.primary),
                );
              },
              child: child!,
            );
          },
        ),
      ),
    );
  }
}



