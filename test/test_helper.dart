import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:provider/provider.dart';

typedef WidgetBuilderNoContext = Widget Function();

extension TesterExtension on WidgetTester {
  /// Test Helper to instantiate and pump widget/screen which depends on Repository [R]
  /// and optionally depends on Provider  [P]. Add non null [args], if the widgets needs arguments from
  /// navigation arguments when it called using:
  /// ```
  /// Navigator.of(context).pushNamed('/path', arguments: args);
  /// ```

  Future<void> pumpScreen<R, P extends ChangeNotifier>({
    required WidgetBuilderNoContext widgetBuilder,
    required R repository,
    P? provider,
    dynamic args,
    MockNavigator? navigator,
  }) async {
    var toTest = widgetBuilder.call();
    if (args != null) {
      toTest = Navigator(
        onGenerateRoute: (_) {
          return MaterialPageRoute<Widget>(
            builder: (_) => widgetBuilder.call(),
            settings: RouteSettings(arguments: args),
          );
        },
      );
    }

    Widget parent = MaterialApp(
      home: MockNavigatorProvider(
        navigator: navigator ?? MockNavigator(),
        child: toTest,
      ),
    );

    if (provider != null) {
      parent = ChangeNotifierProvider<P>.value(
        value: provider,
        child: parent,
      );
    }

    await pumpWidget(
      Provider<R>.value(
        value: repository,
        child: parent,
      ),
    );
  }
}
