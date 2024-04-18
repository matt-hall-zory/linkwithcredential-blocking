import 'dart:async';

import 'package:firebase_anon_bug/src/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServiceFirebase implements AuthService {
  final FirebaseAuth _firebaseAuth;

  final _authEventsStreamController = StreamController<AuthEvent>.broadcast();
  @override
  Stream<AuthEvent> get authEventsStream => _authEventsStreamController.stream;

  AuthServiceFirebase(this._firebaseAuth) {
    _firebaseAuth.authStateChanges().listen((User? firebaseUser) {
      if (firebaseUser == null) {
        debugPrint('Firebase user has signed out');
        _authEventsStreamController.add(AuthEventSignedOut());
      } else {
        debugPrint('Firebase user has signed in or changed email:${firebaseUser.email}');
        _authEventsStreamController.add(AuthEventSignedIn(
          user: UserModel(
            uid: firebaseUser.uid,
            email: firebaseUser.email,
          ),
        ));
      }
    });
  }

  @override
  Future<void> signUpWithAnonymous() async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      debugPrint("Signed in with anonymous account:$userCredential");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          throw Exception("anonymous auth hasn't been enabled for this project.");
        default:
          throw Exception("unknown error:${e.code}\n${e.message}");
      }
    }
  }

  @override
  Future<void> signUpWithPassword(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAuth() async {
    if (_firebaseAuth.currentUser == null) {
      throw Exception("no user to delete");
    }
    try {
      await _firebaseAuth.currentUser?.delete();
      debugPrint("Firebase user has been deleted");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        default:
          throw Exception("unknown error:${e.code}\n${e.message}");
      }
    }
  }
}
