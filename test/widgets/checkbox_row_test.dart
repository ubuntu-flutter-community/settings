import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:settings/view/widgets/checkbox_row.dart';
import '../test_helper.dart';

void main() {
  group('- Check box test', () {
    testWidgets(
      "When `enabled=null` and `value=null` SizedBox is returned",
      (WidgetTester tester) async {
        await tester.pumpScreen(
          widgetBuilder: () => CheckboxRow(
            enabled: null,
            value: null,
            onChanged: (_) {},
            text: 'test text',
          ),
          repository: null,
        );

        expect(find.byType(SizedBox), findsOneWidget);
      },
    );

    testWidgets(
      "When `enabled=true` the check box will be enabled",
      (WidgetTester tester) async {
        await tester.pumpScreen(
          widgetBuilder: () => Scaffold(
            body: CheckboxRow(
              enabled: true,
              value: true,
              onChanged: (_) {},
              text: 'test text',
            ),
          ),
          repository: null,
        );

        expect(find.byType(Checkbox), findsOneWidget);
        expect(find.text('test text'), findsOneWidget);
      },
    );
  });
}
