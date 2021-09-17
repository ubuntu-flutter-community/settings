import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:settings/view/widgets/detail_page.dart';
import 'package:settings/view/widgets/menu_item.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';
import '../test_helper.dart';
import 'package:flutter/material.dart';

void main() {
  group('- Details Page Test', () {
    testWidgets('- Details Page Buid Test', (widgetTester) async {
      await widgetTester.pumpScreen(
        repository: null,
        widgetBuilder: () => const DetailPage(
          item: MenuItem(
            name: 'WIFI',
            iconData: YaruIcons.network_wireless,
            details: Text('WIFI Text'),
          ),
        ),
      );

      expect(find.text('WIFI'), findsOneWidget);
      expect(find.text('WIFI Text'), findsOneWidget);
    });

    testWidgets(
        '- If `tablet(context)==true` the appbar [leading] will be null',
        (widgetTester) async {
      await widgetTester.pumpScreen(
        repository: null,
        widgetBuilder: () => const DetailPage(
          item: MenuItem(
            name: 'WIFI',
            iconData: YaruIcons.network_wireless,
            details: Text('WIFI Text'),
          ),
        ),
      );

      expect(
        find.byType(BackButton),
        findsNothing,
      );
    });

    testWidgets(
        '- If `tablet(context)==false` the appbar [leading] will contain [BackButton]',
        (widgetTester) async {
      const width = 414;
      const height = 846;

      widgetTester.binding.window.devicePixelRatioTestValue = (2.625);
      widgetTester.binding.window.textScaleFactorTestValue = (1.1);

      final dpi = widgetTester.binding.window.devicePixelRatio;
      widgetTester.binding.window.physicalSizeTestValue = Size(
        width * dpi,
        height * dpi,
      );

      await widgetTester.pumpScreen(
        repository: null,
        widgetBuilder: () => const Scaffold(
          body: DetailPage(
            item: MenuItem(
              name: 'WIFI',
              iconData: YaruIcons.network_wireless,
              details: Text('WIFI Text'),
            ),
          ),
        ),
      );

      expect(find.byType(BackButton), findsOneWidget);
      await widgetTester.tap(find.byType(BackButton));
    });
  });
}
