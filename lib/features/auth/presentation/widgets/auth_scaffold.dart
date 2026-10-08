import 'package:flutter/material.dart';

import '../../../../core/responsive.dart';

/// Shared layout for the login/register screens: a logo, then the given
/// [child] form content. Centered in a bounded card on wide/web windows,
/// full-width (just padded) on narrow windows.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final wide = isWideScreen(context);
    final theme = Theme.of(context);

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          Icons.dashboard_customize_outlined,
          size: 48,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(height: 12),
        Text(
          'Team Project Manager',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 24),
        child,
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: wide
                ? ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 440),
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: content,
                      ),
                    ),
                  )
                : content,
          ),
        ),
      ),
    );
  }
}
