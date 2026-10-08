import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:team_project_manager/app/theme.dart';
import 'package:team_project_manager/features/auth/application/auth_controller.dart';
import 'package:team_project_manager/features/auth/data/app_user.dart';
import 'package:team_project_manager/features/auth/presentation/register_screen.dart';

/// Records exactly what [UserRole] the register screen hands to the
/// controller, without touching Firebase — proves whether the toggle's
/// tapped value actually reaches `register()`.
class _RecordingAuthController extends AuthController {
  UserRole? capturedRole;

  @override
  AuthState build() => const AuthState(loading: false);

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required UserRole defaultRole,
  }) async {
    capturedRole = defaultRole;
  }
}

void main() {
  testWidgets(
    'tapping Team Member then Create account sends UserRole.member',
    (tester) async {
      final controller = _RecordingAuthController();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authControllerProvider.overrideWith(() => controller),
          ],
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            home: const RegisterScreen(),
          ),
        ),
      );

      // Sanity check: default toggle state is Project Leader.
      expect(controller.capturedRole, isNull);

      await tester.tap(find.text('Team Member'));
      await tester.pump();

      await tester.enterText(find.widgetWithText(TextFormField, 'Name'), 'Test User');
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'test.member@example.com',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'password123',
      );

      await tester.tap(find.widgetWithText(FilledButton, 'Create account'));
      await tester.pump();

      expect(controller.capturedRole, UserRole.member);
    },
  );

  testWidgets(
    'tapping Project Leader (default) then Create account sends UserRole.leader',
    (tester) async {
      final controller = _RecordingAuthController();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authControllerProvider.overrideWith(() => controller),
          ],
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            home: const RegisterScreen(),
          ),
        ),
      );

      await tester.enterText(find.widgetWithText(TextFormField, 'Name'), 'Test User');
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'test.pm@example.com',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'password123',
      );

      await tester.tap(find.widgetWithText(FilledButton, 'Create account'));
      await tester.pump();

      expect(controller.capturedRole, UserRole.leader);
    },
  );
}
