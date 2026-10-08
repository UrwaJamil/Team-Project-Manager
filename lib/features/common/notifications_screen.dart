import 'package:flutter/material.dart';

import 'placeholder_content.dart';

/// Shared between Project Leader and Member dashboards — the notification center layout
/// doesn't differ by role until real data is wired up.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderContent(
      icon: Icons.notifications_outlined,
      message: 'Notifications\ncoming in a later phase',
    );
  }
}
