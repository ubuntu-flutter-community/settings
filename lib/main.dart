import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gsettings/gsettings.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/widgets/app_theme.dart';
import 'package:settings/view/widgets/master_detail_container.dart';
import 'package:yaru/yaru.dart' as yaru;

void main() {
  final themeSettings = GSettings(schemaId: 'org.gnome.desktop.interface');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AppTheme(themeSettings),
      ),
    ],
    child: const UbuntuSettingsApp(),
  ));
}

class UbuntuSettingsApp extends StatelessWidget {
  const UbuntuSettingsApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ubuntu settings',
      home: const MasterDetailContainer(),
      theme: yaru.lightTheme,
      darkTheme: yaru.darkTheme,
      themeMode: context.watch<AppTheme>().value,
    );
  }
}
