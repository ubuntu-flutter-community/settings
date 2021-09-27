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
import 'package:settings/schemas/schemas.dart';
import 'package:settings/view/widgets/app_theme.dart';
import 'package:settings/view/widgets/master_details_page.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    if (GSettingsSchema.lookup(schemaInterface) != null) {
      final _themeSettings = GSettings(schemaId: schemaInterface);
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
