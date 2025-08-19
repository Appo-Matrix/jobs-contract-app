part of '../di.dart';

void registerOtherDi() {
  getIt.registerSingleton<AuthProvider>(AuthProvider());
}