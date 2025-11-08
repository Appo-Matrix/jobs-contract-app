import '../../../core/constants/global.dart';
import '../../../presentation/features/auth/providers/auth_provider.dart';
import '../../../presentation/global_notifiers/app_config_notifier.dart';

void registerNotifiersDi() {
  getIt.registerSingleton(AppConfigNotifier());
  assert(getIt.isRegistered<AuthProvider>());
}
