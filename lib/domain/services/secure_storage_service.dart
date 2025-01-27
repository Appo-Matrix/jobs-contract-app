import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  const SecureStorageService();
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();


  static Future<String?> get(String key) async {
    try {
      final value = await _secureStorage.read(key: key);
      return value;
    } on Exception catch (e) {
      log('Error encountered $e');
      return null;
    }
  }

  static Future<void> save(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  static Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  static Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }
}