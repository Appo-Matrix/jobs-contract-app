

import 'package:job_contracts/core/constants/global.dart';
import 'package:job_contracts/presentation/features/auth/providers/register_provider.dart';
import 'package:job_contracts/presentation/global_notifiers/app_config_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../features/auth/providers/auth_provider.dart';
import '../features/users/providers/ad_provider.dart';
import '../features/users/providers/application_provider.dart';
import '../features/users/providers/contract_provider.dart';
import '../features/users/providers/current_user_provider.dart';
import '../features/users/providers/job_provider.dart';

List<SingleChildWidget> registerGlobalNotifiers() {
  return [
    ChangeNotifierProvider(create: (_) => getIt<AppConfigNotifier>()),
    ChangeNotifierProvider(create: (_) => getIt<AuthProvider>()),
    ChangeNotifierProvider(create: (_) => getIt<RegisterProvider>()),
    ChangeNotifierProvider(create: (_) => getIt<JobProvider>()),
    ChangeNotifierProvider(create: (_) => getIt<ContractProvider>()),
    ChangeNotifierProvider(create: (_) => getIt<ApplicationProvider>()),
    ChangeNotifierProvider(create: (_) => getIt<AdProvider>()),
    ChangeNotifierProvider(create: (_) => getIt<CurrentUserProvider>()),




  ];
}

