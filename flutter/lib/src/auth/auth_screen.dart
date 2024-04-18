import 'package:firebase_anon_bug/src/auth/auth_service.dart';
import 'package:firebase_anon_bug/src/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authControllerProvider);
    final UserModel? user = controller.currentUser;
    final String? errorMessage = controller.errorMessage;
    return Scaffold(
      appBar: AppBar(
        title: const Text("linkWithCredential"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              if (controller.isBusy) ...[
                const CircularProgressIndicator(),
              ] else if (user == null) ...[
                const Text("User not logged in"),
                ElevatedButton(
                  onPressed: () => controller.signUpAnonymousAuth(),
                  child: const Text("Anonymous Sign Up"),
                ),
              ] else if (user.email == null) ...[
                const Text("Anonymous user"),
                ElevatedButton(
                  onPressed: () => controller.deleteAuth(),
                  child: const Text("Delete User"),
                ),
              ] else ...[
                Text("Registered user: ${user.email}"),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
