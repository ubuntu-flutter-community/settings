import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'package:settings/view/widgets/detail_page.dart';
import 'package:settings/view/widgets/menu_item.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';
import '../test_helper.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('- Details Page Build Test', (widgetTester) async {
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

  testWidgets('- Appbar leading property will be null', (widgetTester) async {
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

  testWidgets('- Appbar leading prop will be set to BackButton ',
      (widgetTester) async {
    /// screen size will be 400.0 * 800.0
    /// To enable [BackButton] width is set to 400
    const width = 400.0;
    const height = 800.0;

    /// Setting screen size
    widgetTester.binding.window.physicalSizeTestValue = const Size(
      width,
      height,
    );

    final navigator = MockNavigator();

    mockito.when(() => navigator.popUntil(any()));

    await widgetTester.pumpScreen(
      navigator: navigator,
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
    await widgetTester.pumpAndSettle();
    verify(() => navigator.popUntil(any())).called(1);

    // resets the screen to its orinal size after the test end
    addTearDown(widgetTester.binding.window.clearPhysicalSizeTestValue);
  });
}
