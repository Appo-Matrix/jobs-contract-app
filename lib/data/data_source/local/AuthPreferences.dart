import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/auth/login_res.dart'; // adjust path to your LoginResponse/User model

/// Handles persistent storage of auth token (secure) and user data (prefs).
/// Usage:
///   await AuthPreferences.saveSession(token: token, user: user);
///   final user = await AuthPreferences.getUser();
///   final token = await AuthPreferences.getToken();
///   final loggedIn = await AuthPreferences.isLoggedIn();
///   await AuthPreferences.clearSession();
class AuthPreferences {
  AuthPreferences._(); // prevent instantiation

  // ── Keys ──────────────────────────────────────────────────────────────────
  static const String _tokenKey    = 'auth_token';
  static const String _userKey     = 'auth_user';
  static const String _loggedInKey = 'is_logged_in';

  // ── Storage instances ─────────────────────────────────────────────────────
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  // ── Save ──────────────────────────────────────────────────────────────────

  /// Save token + user after successful login or registration.
  static Future<void> saveSession({
    required String token,
    required User user,
  }) async {
    try {
      // Token goes to secure storage
      await _secureStorage.write(key: _tokenKey, value: token);

      // User object goes to shared preferences as JSON
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, jsonEncode(user.toJson()));
      await prefs.setBool(_loggedInKey, true);

      debugPrint('✅ AuthPreferences: session saved for ${user.email}');
    } catch (e) {
      debugPrint('❌ AuthPreferences.saveSession error: $e');
      rethrow;
    }
  }

  // ── Read ──────────────────────────────────────────────────────────────────

  /// Returns the stored JWT token or null if not found.
  static Future<String?> getToken() async {
    try {
      final token = await _secureStorage.read(key: _tokenKey);
      debugPrint('🔑 AuthPreferences.getToken: ${token != null ? "found" : "null"}');
      return token;
    } catch (e) {
      debugPrint('❌ AuthPreferences.getToken error: $e');
      return null;
    }
  }

  /// Returns the stored [User] object or null if not found.
  static Future<User?> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      if (userJson == null || userJson.isEmpty) return null;
      final user = User.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
      debugPrint('👤 AuthPreferences.getUser: ${user.email}');
      return user;
    } catch (e) {
      debugPrint('❌ AuthPreferences.getUser error: $e');
      return null;
    }
  }

  /// Returns a [LoginResponse] combining token + user, or null if either missing.
  static Future<LoginResponse?> getSession() async {
    try {
      final token = await getToken();
      final user  = await getUser();
      if (token == null || user == null) return null;
      return LoginResponse(token: token, user: user);
    } catch (e) {
      debugPrint('❌ AuthPreferences.getSession error: $e');
      return null;
    }
  }

  /// Returns true if the user is logged in (token exists in secure storage).
  static Future<bool> isLoggedIn() async {
    try {
      final token = await _secureStorage.read(key: _tokenKey);
      final prefs = await SharedPreferences.getInstance();
      final flag  = prefs.getBool(_loggedInKey) ?? false;
      return flag && (token != null && token.isNotEmpty);
    } catch (e) {
      debugPrint('❌ AuthPreferences.isLoggedIn error: $e');
      return false;
    }
  }

  // ── Update ─────────────────────────────────────────────────────────────────

  /// Update only the user object (e.g. after profile edit).
  static Future<void> updateUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, jsonEncode(user.toJson()));
      debugPrint('✅ AuthPreferences.updateUser: ${user.email}');
    } catch (e) {
      debugPrint('❌ AuthPreferences.updateUser error: $e');
      rethrow;
    }
  }

  /// Update only the token (e.g. after token refresh).
  static Future<void> updateToken(String token) async {
    try {
      await _secureStorage.write(key: _tokenKey, value: token);
      debugPrint('✅ AuthPreferences.updateToken: updated');
    } catch (e) {
      debugPrint('❌ AuthPreferences.updateToken error: $e');
      rethrow;
    }
  }

  // ── Clear ─────────────────────────────────────────────────────────────────

  /// Clear all auth data (logout).
  static Future<void> clearSession() async {
    try {
      await _secureStorage.delete(key: _tokenKey);
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
      await prefs.remove(_loggedInKey);
      debugPrint('🔓 AuthPreferences.clearSession: cleared');
    } catch (e) {
      debugPrint('❌ AuthPreferences.clearSession error: $e');
      rethrow;
    }
  }
}