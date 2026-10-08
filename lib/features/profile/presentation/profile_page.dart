import 'package:flutter/material.dart';

import 'profile_screen.dart';

/// Standalone, pushed version of [ProfileScreen] (own AppBar/back button).
/// Used by the account menu on dashboards that don't have a dedicated
/// Profile nav tab (currently just the Project Leader dashboard).
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const ProfileScreen(),
    );
  }
}
