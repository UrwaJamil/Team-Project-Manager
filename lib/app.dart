import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/theme.dart';
import 'app/theme_mode_controller.dart';
import 'core/user_role.dart';
import 'routing/app_router.dart';

class TeamProjectManagerApp extends ConsumerStatefulWidget {
  const TeamProjectManagerApp({super.key});

  @override
  ConsumerState<TeamProjectManagerApp> createState() =>
      _TeamProjectManagerAppState();
}

class _TeamProjectManagerAppState
    extends ConsumerState<TeamProjectManagerApp> {
  final _session = SessionController();
  late final _router = buildAppRouter(_session);

  @override
  void dispose() {
    _session.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Team Project Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: _router,
    );
  }
}
