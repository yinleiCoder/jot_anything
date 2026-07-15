import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:jot_anything/common/utils/prefs_service.dart';
import 'package:jot_anything/main.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    PrefsService.init(prefs);
  });

  testWidgets('App launches with welcome page', (WidgetTester tester) async {
    await tester.pumpWidget(const JotAnythingApp());

    expect(find.text('记到起'), findsOneWidget);
    expect(find.text('开始使用'), findsOneWidget);
  });

  testWidgets('Welcome button navigates to voice tab', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const JotAnythingApp());

    await tester.ensureVisible(find.text('开始使用'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('开始使用'));
    await tester.pumpAndSettle();

    expect(find.text('语音'), findsWidgets);
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
