abstract class AuthService {
  Stream<AuthEvent> get authEventsStream;
  Future<void> signUpWithAnonymous();
  Future<void> linkAnonymousWithEmail({required String email, required String password});
  Future<void> deleteAuth();
}

class UserModel {
  final String uid;
  final String? email;
  const UserModel({required this.uid, required this.email});
}

sealed class AuthEvent {}

class AuthEventSignedIn extends AuthEvent {
  final UserModel user;
  AuthEventSignedIn({
    required this.user,
  });
  bool get isAnonymous => user.email == null;
}

class AuthEventSignedOut extends AuthEvent {}
