
import 'package:job_contract_app/presentation/features/users/account_screen/provider/change_password_provider.dart';
import 'package:job_contract_app/presentation/features/users/blog/provider/blog_provider.dart';

import '../../core/constants/global.dart';
import '../features/auth/providers/register_provider.dart';
import '../features/users/account_screen/provider/recent_job_provider.dart';
import '../features/users/home/job_details/provider/job_application_provider.dart';
import '../global_notifiers/app_config_notifier.dart';
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
    ChangeNotifierProvider(create: (_) => getIt<BlogProvider>()),
    ChangeNotifierProvider(create: (_) => getIt<JobApplicationProvider>()),
    ChangeNotifierProvider(create: (_) => getIt<ChangePasswordProvider>()),
    ChangeNotifierProvider(create: (_) => getIt<RecentJobProvider>()),
  ];
}

