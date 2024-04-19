import 'package:firebase_anon_bug/src/auth/auth_service.dart';
import 'package:firebase_anon_bug/src/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => controller.signUpAnonymousAuth(),
                  child: const Text("Anonymous Sign Up"),
                ),
              ] else if (user.email == null) ...[
                const Text("Anonymous user"),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        inputFormatters: [LowerCaseTextFormatter()],
                        controller: emailTextController,
                        decoration: const InputDecoration(labelText: "Email"),
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        autocorrect: false,
                        validator: (val) => validateEmail(val) ? null : "Enter valid email",
                      ),
                      TextFormField(
                        controller: passwordTextController,
                        obscureText: true,
                        autocorrect: false,
                        enableSuggestions: false,
                        autofillHints: const [AutofillHints.newPassword],
                        decoration: const InputDecoration(labelText: "Password"),
                        validator: (val) => validateEmail(val) ? null : "Enter valid password",
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => controller.linkAnonymousAuthWithEmail(
                          email: emailTextController.text,
                          password: passwordTextController.text,
                        ),
                        child: const Text("Link with Email"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => controller.deleteAuth(),
                  child: const Text("Delete User"),
                ),
              ] else ...[
                Text("Registered user: ${user.email}"),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => controller.deleteAuth(),
                  child: const Text("Delete User"),
                ),
              ],
              const SizedBox(height: 8),
              const Text("""To reproduce bug:
1. Sign up anonymous account.
2. Enter email & password and link anonymous account with email.
This will succeed against emulator, but live firebase will trigger blocking function.
Blocking function should NOT be triggered when calling linkWithCredential."""),
            ],
          ),
        ),
      ),
    );
  }
}

bool validateEmail(String? value) {
  const pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  final regex = RegExp(pattern);
  if (value == null || regex.firstMatch(value) == null) {
    return false;
  } else {
    return true;
  }
}

bool validateLoginPassword(String? value) {
  if ((value?.length ?? 0) < 8) {
    return false;
  } else {
    return true;
  }
}
