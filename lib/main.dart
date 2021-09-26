import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gsettings/gsettings.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/hostname_service.dart';
import 'package:settings/view/pages/page_items.dart';
import 'package:settings/view/widgets/app_theme.dart';
import 'package:settings/view/widgets/landscape_layout.dart';
import 'package:settings/view/widgets/portrait_layout.dart';
import 'package:udisks/udisks.dart';
import 'package:yaru/yaru.dart' as yaru;
import 'package:window_size/window_size.dart' as window_size;

void main() async {
  final themeSettings = GSettings(schemaId: 'org.gnome.desktop.interface');

  WidgetsFlutterBinding.ensureInitialized();
  var window = await window_size.getWindowInfo();
  if (window.screen != null) {
    const width = 600.0;
    const height = 700.0;
    window_size.setWindowMinSize(const Size(1.0 * width, 1.0 * height));
    window_size.setWindowTitle('Ubuntu Settings');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppTheme(themeSettings),
        ),
        Provider<HostnameService>(
          create: (_) => HostnameService(),
          dispose: (_, service) => service.dispose(),
        ),
        Provider<UDisksClient>(
          create: (_) => UDisksClient(),
          dispose: (_, client) => client.close(),
        ),
      ],
      child: const UbuntuSettingsApp(),
    ),
  );
}

class UbuntuSettingsApp extends StatelessWidget {
  const UbuntuSettingsApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ubuntu settings',
      home: const MasterDetailPage(),
      theme: yaru.lightTheme,
      darkTheme: yaru.darkTheme,
      themeMode: context.watch<AppTheme>().value,
    );
  }
}

class MasterDetailPage extends StatefulWidget {
  const MasterDetailPage({Key? key}) : super(key: key);

  @override
  _MasterDetailPageState createState() => _MasterDetailPageState();
}

class _MasterDetailPageState extends State<MasterDetailPage> {
  var _index = -1;
  var _previousIndex = 0;

  void _setIndex(int index) {
    _previousIndex = _index;
    _index = index;
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        switch (orientation) {
          case Orientation.portrait:
            return PortraitLayout(
              selectedIndex: _index,
              pages: pageItems,
              onSelected: _setIndex,
            );
          case Orientation.landscape:
            return LandscapeLayout(
              selectedIndex: _index == -1 ? _previousIndex : _index,
              pages: pageItems,
              onSelected: _setIndex,
            );
        }
      },
    );
  }
}
