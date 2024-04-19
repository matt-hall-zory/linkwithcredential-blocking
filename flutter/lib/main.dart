import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_anon_bug/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';

void main() async {
  // initialise core firebase plugin
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // initialise firebase emulator (if needed)
  if (const bool.fromEnvironment('USE_FIREBASE_EMULATOR')) {
    const host = 'localhost';
    FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
    await FirebaseAuth.instance.useAuthEmulator(host, 9099);
    await Future.delayed(const Duration(milliseconds: 500)); // ensure emulator is connected
    debugPrint("using LOCAL FIREBASE AUTH, & FUNCTIONS! ======");
  }

  runApp(const ProviderScope(child: App()));
}
