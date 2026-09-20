import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/placeholder_content.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.projectId});

  final String projectId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Project: $projectId')),
      body: PlaceholderContent(
        icon: Icons.view_kanban_outlined,
        message:
            'Project Detail\n(Kanban board + members + chat access)\ncoming in a later phase',
        child: FilledButton.tonal(
          onPressed: () =>
              context.go('/pm/projects/$projectId/tasks/demo-task'),
          child: const Text('Open demo task detail'),
        ),
      ),
    );
  }
}
