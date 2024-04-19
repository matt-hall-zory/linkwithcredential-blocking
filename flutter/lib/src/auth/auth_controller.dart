import 'package:flutter/material.dart';

import 'auth_service.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService;
  AuthController(this._authService) {
    _authService.authEventsStream.forEach(
      (auth) {
        switch (auth) {
          case AuthEventSignedIn():
            _currentUser = auth.user;
          case AuthEventSignedOut():
            _currentUser = null;
        }
        notifyListeners();
      },
    );
  }

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  Future<void> signUpAnonymousAuth() async {
    start();
    try {
      await _authService.signUpWithAnonymous();
    } catch (e) {
      _errorMessage = "authService.signUpWithAnonymous failed: $e";
    }
    end();
  }

  Future<void> linkAnonymousAuthWithEmail({required String email, required String password}) async {
    start();
    try {
      await _authService.linkAnonymousWithEmail(email: email, password: password);
    } catch (e) {
      _errorMessage = "authService.linkAnonymousAuthWithEmail failed: $e";
    }
    end();
  }

  Future<void> deleteAuth() async {
    start();
    try {
      await _authService.deleteAuth();
    } catch (e) {
      _errorMessage = "authService.deleteAuth failed: $e";
    }
    end();
  }

  void start() {
    _errorMessage = null;
    _isBusy = true;
    notifyListeners();
  }

  void end() {
    _isBusy = false;
    notifyListeners();
  }
}
