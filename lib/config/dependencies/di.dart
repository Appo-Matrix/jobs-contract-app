

import 'package:job_contracts/core/constants/global.dart';

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