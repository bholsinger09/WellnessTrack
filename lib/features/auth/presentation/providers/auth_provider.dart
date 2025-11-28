import 'package:flutter/foundation.dart';
import '../../domain/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

enum AuthStatus {
  initial,
  authenticated,
  unauthenticated,
  loading,
  error,
}

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  
  AuthStatus _status = AuthStatus.initial;
  UserModel? _user;
  String? _errorMessage;

  AuthProvider({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository();

  AuthStatus get status => _status;
  UserModel? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  // Sign up
  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      _setStatus(AuthStatus.loading);
      _user = await _authRepository.signUp(
        email: email,
        password: password,
        displayName: displayName,
      );
      _setStatus(AuthStatus.authenticated);
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Sign in
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _setStatus(AuthStatus.loading);
      _user = await _authRepository.signIn(
        email: email,
        password: password,
      );
      _setStatus(AuthStatus.authenticated);
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Sign in anonymously
  Future<void> signInAnonymously() async {
    try {
      _setStatus(AuthStatus.loading);
      _user = await _authRepository.signInAnonymously();
      _setStatus(AuthStatus.authenticated);
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      _setStatus(AuthStatus.loading);
      await _authRepository.signOut();
      _user = null;
      _setStatus(AuthStatus.unauthenticated);
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      _setStatus(AuthStatus.loading);
      await _authRepository.resetPassword(email);
      _setStatus(AuthStatus.unauthenticated);
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Check auth state
  Future<void> checkAuthState() async {
    try {
      _setStatus(AuthStatus.loading);
      final currentUser = _authRepository.currentUser;
      
      if (currentUser != null) {
        _user = await _authRepository.getUserData(currentUser.uid);
        _setStatus(AuthStatus.authenticated);
      } else {
        _setStatus(AuthStatus.unauthenticated);
      }
    } catch (e) {
      _setError(e.toString());
    }
  }

  void _setStatus(AuthStatus status) {
    _status = status;
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String message) {
    _status = AuthStatus.error;
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
