import 'package:job_contracts/presentation/features/auth/providers/register_provider.dart';

import '../../../core/constants/global.dart';
import '../../../presentation/features/auth/providers/auth_provider.dart';
import '../../../presentation/features/users/providers/ad_provider.dart';
import '../../../presentation/features/users/providers/application_provider.dart';
import '../../../presentation/features/users/providers/contract_provider.dart';
import '../../../presentation/features/users/providers/current_user_provider.dart';
import '../../../presentation/features/users/providers/job_provider.dart';
import '../../../presentation/global_notifiers/app_config_notifier.dart';

void registerNotifiersDi() {
  getIt.registerSingleton(AppConfigNotifier());
  assert(getIt.isRegistered<AuthProvider>());
  assert(getIt.isRegistered<RegisterProvider>());
  assert(getIt.isRegistered<JobProvider>());
  assert(getIt.isRegistered<ContractProvider>());
  assert(getIt.isRegistered<ApplicationProvider>());
  assert(getIt.isRegistered<AdProvider>());
  assert(getIt.isRegistered<CurrentUserProvider>());
}
