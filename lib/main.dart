import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

void main() {

  // AppServices.initialize();
  // registerNotifiersDi();
  // AppConfig().initialize();
  runApp(const JobContractsApp());
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
    debugPrint("un pausing");
  //  FlutterNativeSplash.remove();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MultiProvider(
        providers: [],
       // providers: registerGlobalNotifiers(),
        child: MaterialApp.router(
          // theme: ,
          debugShowCheckedModeBanner: false,
          //routerConfig: AppRouter.router,
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



