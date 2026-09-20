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
        icon: Icons.folder_shared_outlined,
        message:
            'Project Detail\n(full read-only view, own tasks editable)\ncoming in a later phase',
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: () =>
                  context.go('/member/projects/$projectId/tasks/demo-task'),
              child: const Text('Open demo task detail'),
            ),
            OutlinedButton(
              onPressed: () =>
                  context.go('/member/projects/$projectId/chat'),
              child: const Text('Open project chat'),
            ),
          ],
        ),
      ),
    );
  }
}
