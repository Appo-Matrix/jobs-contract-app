


import '../../core/constants/global.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../presentation/features/auth/providers/auth_provider.dart';
import '../../presentation/global_notifiers/app_config_notifier.dart';

part 'src/ds_di.dart';
part 'src/notifiers_di.dart';
part 'src/other_di.dart';
part 'src/repo_di.dart';
void registerGetItDependencies(){
  registerDataSourcesDi();
  registerRepositoriesDi();
  registerNotifiersDi();
  registerOtherDi();
}