import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_anon_bug/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  // initialise core firebase plugin
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // initialise firebase emulator (if needed)
  if (const bool.fromEnvironment('USE_FIREBASE_EMULATOR')) {
    const host = 'localhost';
    FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
    await FirebaseAuth.instance.useAuthEmulator(host, 9099);
  }

  runApp(MyApp(settingsController: settingsController));
}
