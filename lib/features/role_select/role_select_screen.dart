import 'package:flutter/material.dart';

import '../../core/user_role.dart';

/// Stand-in for real login/role assignment (auth is deferred until the
/// backend decision is made). Lets a developer/tester pick which dashboard
/// to view.
class RoleSelectScreen extends StatelessWidget {
  const RoleSelectScreen({super.key, required this.session});

  final SessionController session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.dashboard_customize_outlined, size: 56),
                const SizedBox(height: 16),
                Text(
                  'Team Project Manager',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose a dashboard to continue',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                FilledButton.icon(
                  onPressed: () => session.selectRole(UserRole.pm),
                  icon: const Icon(Icons.supervisor_account_outlined),
                  label: const Text('Project Leader (PM) Dashboard'),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => session.selectRole(UserRole.member),
                  icon: const Icon(Icons.person_outline),
                  label: const Text('Team Member Dashboard'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
