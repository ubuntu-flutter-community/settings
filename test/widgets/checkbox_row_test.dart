import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaru_widgets/yaru_widgets.dart';
import '../test_helper.dart';

void main() {
  group('- Check box test', () {
    testWidgets(
      "When `enabled=null` and `value=null` SizedBox is returned",
      (WidgetTester tester) async {
        await tester.pumpScreen(
          widgetBuilder: () => YaruCheckboxRow(
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
            body: YaruCheckboxRow(
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
