import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/placeholder_content.dart';

class ProjectsOverviewScreen extends StatelessWidget {
  const ProjectsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderContent(
      icon: Icons.folder_open_outlined,
      message:
          'Projects Overview\n(list + progress %, create/edit project)\ncoming in a later phase',
      child: FilledButton.tonal(
        onPressed: () => context.go('/leader/projects/demo-project'),
        child: const Text('Open demo project detail'),
      ),
    );
  }
}
