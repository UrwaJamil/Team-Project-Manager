import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:team_project_manager/app.dart';

void main() {
  testWidgets('shows role select screen and can enter PM dashboard', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: TeamProjectManagerApp()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Team Project Manager'), findsOneWidget);
    expect(find.text('Project Leader (PM) Dashboard'), findsOneWidget);

    await tester.tap(find.text('Project Leader (PM) Dashboard'));
    await tester.pumpAndSettle();

    expect(find.text('PM Dashboard'), findsOneWidget);
  });

  testWidgets('narrow layout shows a bottom navigation bar', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const ProviderScope(child: TeamProjectManagerApp()),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Team Member Dashboard'));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
  });

  testWidgets('wide layout shows a navigation rail sidebar', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1300, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const ProviderScope(child: TeamProjectManagerApp()),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Team Member Dashboard'));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });
}
