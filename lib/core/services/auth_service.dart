// /*
// import 'dart:developer';
// import 'package:shared_preferences/shared_preferences.dart';
//
// /// Service to manage authentication tokens and user session
// class AuthService {
//   static const String _tokenKey = 'auth_token';
//   static const String _userKey = 'user_data';
//   static const String _isLoggedInKey = 'is_logged_in';
//
//   // Singleton pattern
//   static final AuthService _instance = AuthService._internal();
//   factory AuthService() => _instance;
//   AuthService._internal();
//
//   SharedPreferences? _prefs;
//
//   /// Initialize the service
//   Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//     log('✅ AuthService initialized');
//   }
//
//   /// Get the current authentication token
//   Future<String?> getToken() async {
//     try {
//       _prefs ??= await SharedPreferences.getInstance();
//       final token = _prefs?.getString(_tokenKey);
//
//       if (token != null && token.isNotEmpty) {
//         log('🔑 Token retrieved successfully');
//         return token;
//       } else {
//         log('⚠️ No token found');
//         return null;
//       }
//     } catch (e) {
//       log('❌ Error getting token: $e');
//       return null;
//     }
//   }
//
//   /// Save authentication token
//   Future<bool> saveToken(String token) async {
//     try {
//       _prefs ??= await SharedPreferences.getInstance();
//       final result = await _prefs?.setString(_tokenKey, token);
//
//       if (result == true) {
//         log('✅ Token saved successfully');
//         return true;
//       }
//       return false;
//     } catch (e) {
//       log('❌ Error saving token: $e');
//       return false;
//     }
//   }
//
//   /// Check if user is authenticated
//   Future<bool> isAuthenticated() async {
//     try {
//       _prefs ??= await SharedPreferences.getInstance();
//       final token = await getToken();
//       final isLoggedIn = _prefs?.getBool(_isLoggedInKey) ?? false;
//
//       return token != null && token.isNotEmpty && isLoggedIn;
//     } catch (e) {
//       log('❌ Error checking authentication: $e');
//       return false;
//     }
//   }
//
//   /// Set login status
//   Future<bool> setLoginStatus(bool status) async {
//     try {
//       _prefs ??= await SharedPreferences.getInstance();
//       return await _prefs?.setBool(_isLoggedInKey, status) ?? false;
//     } catch (e) {
//       log('❌ Error setting login status: $e');
//       return false;
//     }
//   }
//
//   /// Save user data
//   Future<bool> saveUserData(String userData) async {
//     try {
//       _prefs ??= await SharedPreferences.getInstance();
//       return await _prefs?.setString(_userKey, userData) ?? false;
//     } catch (e) {
//       log('❌ Error saving user data: $e');
//       return false;
//     }
//   }
//
//   /// Get user data
//   Future<String?> getUserData() async {
//     try {
//       _prefs ??= await SharedPreferences.getInstance();
//       return _prefs?.getString(_userKey);
//     } catch (e) {
//       log('❌ Error getting user data: $e');
//       return null;
//     }
//   }
//
//   /// Clear all authentication data (logout)
//   Future<bool> clearAuth() async {
//     try {
//       _prefs ??= await SharedPreferences.getInstance();
//       await _prefs?.remove(_tokenKey);
//       await _prefs?.remove(_userKey);
//       await _prefs?.remove(_isLoggedInKey);
//       log('✅ Auth data cleared');
//       return true;
//     } catch (e) {
//       log('❌ Error clearing auth: $e');
//       return false;
//     }
//   }
//
//   /// Get bearer token formatted for API requests
//   Future<String?> getBearerToken() async {
//     final token = await getToken();
//     if (token != null && token.isNotEmpty) {
//       return 'Bearer $token';
//     }
//     return null;
//   }
// }*/
