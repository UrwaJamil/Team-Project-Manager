import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/theme_mode_menu_button.dart';
import '../features/auth/presentation/widgets/sign_out_button.dart';
import 'adaptive_shell.dart';

const memberDestinations = [
  NavDestinationSpec(
    icon: Icons.checklist_outlined,
    selectedIcon: Icons.checklist,
    label: 'My Tasks',
  ),
  NavDestinationSpec(
    icon: Icons.event_busy_outlined,
    selectedIcon: Icons.event_busy,
    label: 'Leave',
  ),
  NavDestinationSpec(
    icon: Icons.notifications_outlined,
    selectedIcon: Icons.notifications,
    label: 'Alerts',
  ),
  NavDestinationSpec(
    icon: Icons.person_outline,
    selectedIcon: Icons.person,
    label: 'Profile',
  ),
];

class MemberShell extends StatelessWidget {
  const MemberShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return AdaptiveShell(
      title: 'Member Dashboard',
      destinations: memberDestinations,
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      ),
      actions: [const ThemeModeMenuButton(), const SignOutButton()],
      body: navigationShell,
    );
  }
}
