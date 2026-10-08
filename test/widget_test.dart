import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:team_project_manager/app/theme.dart';
import 'package:team_project_manager/features/auth/presentation/login_screen.dart';
import 'package:team_project_manager/features/auth/presentation/register_screen.dart';

// These tests render the login/register screens in isolation (not the
// full app/router), since the full app reaches Firebase as soon as it
// builds (via authControllerProvider), which isn't available under
// `flutter test` without a Firebase emulator/mocking setup — out of scope
// for this phase. CLAUDE.md's testing rule to add once repositories exist:
// cover permission logic, not these widgets' Firebase calls directly.
Widget _wrap(Widget child) {
  return ProviderScope(
    child: MaterialApp(
      theme: AppTheme.lightTheme,
      home: child,
    ),
  );
}

void main() {
  testWidgets('login screen shows logo, role toggle, fields and link', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_wrap(const LoginScreen()));

    expect(find.text('Team Project Manager'), findsOneWidget);
    expect(find.text('Project Leader'), findsOneWidget);
    expect(find.text('Team Member'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Login'), findsOneWidget);
    expect(
      find.text("Don't have an account? Create new account"),
      findsOneWidget,
    );
  });

  testWidgets('register screen shows logo, role toggle, fields and link', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_wrap(const RegisterScreen()));

    expect(find.text('Team Project Manager'), findsOneWidget);
    expect(find.text('Project Leader'), findsOneWidget);
    expect(find.text('Team Member'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(
      find.widgetWithText(FilledButton, 'Create account'),
      findsOneWidget,
    );
    expect(find.text('Already have an account? Log in'), findsOneWidget);
  });

  testWidgets('login validation blocks submit with empty fields', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_wrap(const LoginScreen()));

    await tester.tap(find.widgetWithText(FilledButton, 'Login'));
    await tester.pump();

    expect(find.text('Enter a valid email'), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);
  });

  testWidgets('narrow layout shows login form without a bounding card', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_wrap(const LoginScreen()));

    expect(find.byType(Card), findsNothing);
  });

  testWidgets('wide layout centers the login form in a card', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1300, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_wrap(const LoginScreen()));

    expect(find.byType(Card), findsOneWidget);
  });
}
