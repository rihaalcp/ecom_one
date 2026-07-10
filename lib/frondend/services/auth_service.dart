import 'package:flutter/foundation.dart';

/// A minimal, app-wide auth session holder.
///
/// This is intentionally backend-agnostic: swap [login]/[register] with
/// real API calls later without touching any screen code, since screens
/// only ever talk to [AuthService.instance].
class AuthService extends ChangeNotifier {
  AuthService._internal();
  static final AuthService instance = AuthService._internal();

  bool _isLoggedIn = false;
  String? _userName;
  String? _userEmail;

  bool get isLoggedIn => _isLoggedIn;
  String? get userName => _userName;
  String? get userEmail => _userEmail;

  /// Mock login - replace the body with a real API call when ready.
  Future<bool> login({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 700));
    _isLoggedIn = true;
    _userEmail = email;
    _userName ??= email.split('@').first;
    notifyListeners();
    return true;
  }

  /// Mock registration - replace the body with a real API call when ready.
  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 900));
    _isLoggedIn = true;
    _userName = name;
    _userEmail = email;
    notifyListeners();
    return true;
  }

  void logout() {
    _isLoggedIn = false;
    _userName = null;
    _userEmail = null;
    notifyListeners();
  }
}