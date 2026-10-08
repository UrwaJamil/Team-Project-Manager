import 'package:flutter/material.dart';

import '../../data/app_user.dart';

/// Shared Project Leader / Team Member toggle used on both the login and
/// register screens (CLAUDE.md "Login and register screen layout").
class RoleToggle extends StatelessWidget {
  const RoleToggle({super.key, required this.value, required this.onChanged});

  final UserRole value;
  final ValueChanged<UserRole> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<UserRole>(
      segments: [
        ButtonSegment(
          value: UserRole.leader,
          label: Text(UserRole.leader.label),
          icon: const Icon(Icons.supervisor_account_outlined),
        ),
        ButtonSegment(
          value: UserRole.member,
          label: Text(UserRole.member.label),
          icon: const Icon(Icons.person_outline),
        ),
      ],
      selected: {value},
      onSelectionChanged: (selection) => onChanged(selection.first),
    );
  }
}
