import 'package:firebase_anon_bug/src/auth/auth_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      theme: ThemeData(),
      home: const AuthScreen(),
    );
  }
}
