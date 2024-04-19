import 'package:firebase_anon_bug/src/auth/auth_controller.dart';
import 'package:firebase_anon_bug/src/auth/auth_service.dart';
import 'package:firebase_anon_bug/src/auth/auth_service_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authServiceProvider = Provider<AuthService>((ref) => AuthServiceFirebase(ref.watch(firebaseAuthProvider)));

final authControllerProvider = ChangeNotifierProvider((ref) {
  return AuthController(
    ref.watch(authServiceProvider),
  );
});
