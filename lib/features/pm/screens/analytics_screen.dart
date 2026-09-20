import 'package:flutter/material.dart';

import '../../common/placeholder_content.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderContent(
      icon: Icons.insights_outlined,
      message:
          'Analytics/Reports\n(team performance, overdue tasks, workload)\ncoming in a later phase',
    );
  }
}
