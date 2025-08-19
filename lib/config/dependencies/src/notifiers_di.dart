part of '../di.dart';


void registerNotifiersDi() {

 getIt
  ..registerSingleton(AppConfigNotifier())
  ..registerSingleton(AuthProvider())
 ..registerSingleton(RegisterProvider());



}