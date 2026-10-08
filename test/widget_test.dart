import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:team_project_manager/app/theme.dart';
import 'package:team_project_manager/features/auth/presentation/login_screen.dart';
import 'package:team_project_manager/features/auth/presentation/register_screen.dart';

import 'support/fake_auth.dart';

// These tests render the login/register screens in isolation (not the
// full app/router), with in-memory fakes in place of the Firebase-backed
// repositories.
Widget _wrap(Widget child) {
  return ProviderScope(
    overrides: fakeAuthOverrides(),
    child: MaterialApp(
      theme: AppTheme.lightTheme,
      home: child,
    ),
  );
}

void main() {
  testWidgets('login screen shows logo, fields and link, but no role toggle', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_wrap(const LoginScreen()));

    expect(find.text('Team Project Manager'), findsOneWidget);
    // The landing dashboard comes from users/{uid}.defaultRole, never a
    // login-screen choice.
    expect(find.text('Project Leader'), findsNothing);
    expect(find.text('Team Member'), findsNothing);
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
