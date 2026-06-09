import '../models/user.dart';

class AuthRepository {
  User? _currentUser;

  Future<User?> login(String email, String password) async {
    // Mock login logic
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'admin@netguard.com' && password == 'password123') {
      _currentUser = User(
        id: '1',
        username: 'Admin User',
        email: email,
      );
      return _currentUser;
    }
    return null;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  User? get currentUser => _currentUser;
}
