import 'package:bluez/bluez.dart';
import 'package:flutter/material.dart';
import 'package:nm/nm.dart';
import 'package:provider/provider.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/bluetooth_service.dart';
import 'package:settings/services/hostname_service.dart';
import 'package:settings/services/power_profile_service.dart';
import 'package:settings/services/power_settings_service.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/app_theme.dart';
import 'package:settings/view/pages/page_items.dart';
import 'package:udisks/udisks.dart';
import 'package:upower/upower.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

void main() async {
  final themeSettings = Settings(schemaInterface);

  final networkManagerClient = NetworkManagerClient();
  await networkManagerClient.connect();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppTheme(themeSettings),
        ),
        Provider<BluetoothService>(
          create: (_) => BluetoothService(),
          dispose: (_, service) => service.dispose(),
        ),
        Provider<HostnameService>(
          create: (_) => HostnameService(),
          dispose: (_, service) => service.dispose(),
        ),
        Provider<NetworkManagerClient>.value(value: networkManagerClient),
        Provider<PowerProfileService>(
          create: (_) => PowerProfileService(),
          dispose: (_, service) => service.dispose(),
        ),
        Provider<PowerSettingsService>(
          create: (_) => PowerSettingsService(),
          dispose: (_, service) => service.dispose(),
        ),
        Provider<SettingsService>(
          create: (_) => SettingsService(),
          dispose: (_, service) => service.dispose(),
        ),
        Provider<UDisksClient>(
          create: (_) => UDisksClient(),
          dispose: (_, client) => client.close(),
        ),
        Provider<UPowerClient>(
          create: (_) => UPowerClient(),
          dispose: (_, client) => client.close(),
        ),
        Provider<BlueZClient>(
          create: (_) => BlueZClient(),
          dispose: (_, client) => client.close(),
        )
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
      onGenerateTitle: (context) => context.l10n.appTitle,
      routes: {
        Navigator.defaultRouteName: (context) {
          return YaruMasterDetailPage(
            appBarHeight: 48,
            leftPaneWidth: 280,
            pageItems: pageItems,
            previousIconData: YaruIcons.go_previous,
            searchHint: context.l10n.searchHint,
            searchIconData: YaruIcons.search,
          );
        },
      },
      theme: yaruLight,
      darkTheme: yaruDark,
      themeMode: context.watch<AppTheme>().value,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
