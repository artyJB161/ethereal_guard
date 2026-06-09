import 'package:flutter/material.dart';
import '../repositories/auth_repository.dart';
import '../models/user.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  bool _isLoading = false;
  String? _errorMessage;

  AuthViewModel(this._authRepository);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get user => _authRepository.currentUser;
  bool get isAuthenticated => user != null;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _authRepository.login(email, password);
      if (result != null) {
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Invalid email or password';
      }
    } catch (e) {
      _errorMessage = 'An error occurred during login';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  void logout() async {
    await _authRepository.logout();
    notifyListeners();
  }
}
