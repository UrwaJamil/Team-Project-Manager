import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/placeholder_content.dart';

class MyTasksScreen extends StatelessWidget {
  const MyTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderContent(
      icon: Icons.checklist_outlined,
      message:
          'My Tasks\n(across all projects, sorted by deadline)\ncoming in a later phase',
      child: FilledButton.tonal(
        onPressed: () => context.go('/member/projects/demo-project'),
        child: const Text('Open demo project detail'),
      ),
    );
  }
}
