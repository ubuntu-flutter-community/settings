// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gsettings/gsettings.dart';
import 'package:provider/provider.dart';
import 'package:settings/main.dart';
import 'package:settings/view/widgets/app_theme.dart';

void main() {
  const _schemaKey = 'org.gnome.desktop.interface';

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    if (GSettingsSchema.lookup(_schemaKey) != null) {
      final _themeSettings = GSettings(schemaId: _schemaKey);
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => AppTheme(_themeSettings),
          child: const MaterialApp(
            home: UbuntuSettingsApp(),
          ),
        ),
      );

      expect(find.byType(MasterDetailPage), findsNWidgets(1));
    }
  });
}
