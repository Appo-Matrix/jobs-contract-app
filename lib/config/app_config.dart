

import 'package:job_contracts/config/dependencies/di.dart';

class AppConfig{

  factory AppConfig() {
    return _singleton;
  }
  AppConfig._internal();
  static final AppConfig _singleton = AppConfig._internal();

  late final String _configStatus;
  void setup(){
    try {
      registerGetItDependencies();
      _configStatus = 'Configured';
    } catch (e) {
      _configStatus = 'Not Configured';
    }
  }

  Future<void> initialize() async {
    try {
      _configStatus = 'Initialized';
    } catch (e) {
      _configStatus = 'Not Initialized';
    }
  }

  @override
  String toString() => 'AppConfig:\n -Config Status: $_configStatus';
}