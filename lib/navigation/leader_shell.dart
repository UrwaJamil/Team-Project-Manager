import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/theme_mode_menu_button.dart';
import '../features/auth/presentation/widgets/sign_out_button.dart';
import 'adaptive_shell.dart';

const leaderDestinations = [
  NavDestinationSpec(
    icon: Icons.folder_open_outlined,
    selectedIcon: Icons.folder_open,
    label: 'Projects',
  ),
  NavDestinationSpec(
    icon: Icons.groups_outlined,
    selectedIcon: Icons.groups,
    label: 'Team',
  ),
  NavDestinationSpec(
    icon: Icons.event_busy_outlined,
    selectedIcon: Icons.event_busy,
    label: 'Leave',
  ),
  NavDestinationSpec(
    icon: Icons.calendar_month_outlined,
    selectedIcon: Icons.calendar_month,
    label: 'Calendar',
  ),
  NavDestinationSpec(
    icon: Icons.insights_outlined,
    selectedIcon: Icons.insights,
    label: 'Analytics',
  ),
  NavDestinationSpec(
    icon: Icons.notifications_outlined,
    selectedIcon: Icons.notifications,
    label: 'Alerts',
  ),
];

class LeaderShell extends StatelessWidget {
  const LeaderShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return AdaptiveShell(
      title: 'Project Leader Dashboard',
      destinations: leaderDestinations,
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      ),
      actions: [
        const ThemeModeMenuButton(),
        IconButton(
          tooltip: 'Profile',
          onPressed: () => context.push('/profile'),
          icon: const Icon(Icons.person_outline),
        ),
        const SignOutButton(),
      ],
      body: navigationShell,
    );
  }
}
