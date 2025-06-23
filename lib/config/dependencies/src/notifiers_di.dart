part of '../di.dart';


void registerNotifiersDi() {

 getIt.registerSingleton(AppConfigNotifier());

  assert(getIt.isRegistered<AuthProvider>());

}