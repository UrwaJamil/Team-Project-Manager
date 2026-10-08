import 'package:flutter/material.dart';

/// Shown briefly while the router waits to learn whether a Firebase
/// session already exists, so logged-out/logged-in users never flash the
/// wrong screen first.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
