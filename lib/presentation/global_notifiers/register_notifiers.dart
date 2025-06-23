

import 'package:job_contracts/core/constants/global.dart';
import 'package:job_contracts/presentation/global_notifiers/app_config_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../features/auth/providers/auth_provider.dart';

List<SingleChildWidget> registerGlobalNotifiers() {
  return [
    ChangeNotifierProvider(create: (_) => getIt<AppConfigNotifier>()),
    ChangeNotifierProvider(create: (_) => getIt<AuthProvider>()),




  ];
}

