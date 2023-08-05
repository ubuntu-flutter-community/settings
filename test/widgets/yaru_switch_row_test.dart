import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

void main() {
  testWidgets('- YaruSwitchRow Test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: YaruSwitchRow(
            onChanged: (v) {},
            trailingWidget: const Text('Trailing Widget'),
            value: true,
            actionDescription: 'Description',
          ),
        ),
      ),
    );

    // Use [widget] if you only expect to match one widget.
    // Throws a [StateError] if finder is empty or matches more than one widget.
    final findValue = (tester.widget(find.byType(Switch)) as Switch).value;

    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Trailing Widget'), findsOneWidget);
    expect(find.byType(YaruTile), findsOneWidget);
    expect(findValue, true);
  });
}
