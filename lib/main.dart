import 'package:bluez/bluez.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nm/nm.dart';
import 'package:provider/provider.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/bluetooth_service.dart';
import 'package:settings/services/hostname_service.dart';
import 'package:settings/services/input_source_service.dart';
import 'package:settings/services/power_profile_service.dart';
import 'package:settings/services/power_settings_service.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/app_theme.dart';
import 'package:settings/view/pages/page_items.dart';
import 'package:udisks/udisks.dart';
import 'package:upower/upower.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

void main() async {
  final themeSettings = Settings(schemaInterface);

  final networkManagerClient = NetworkManagerClient();
  await networkManagerClient.connect();
  final getIt = GetIt.instance;
  getIt.registerSingleton<SettingsService>(SettingsService());
  getIt.registerSingleton<NetworkManagerClient>(networkManagerClient);
  getIt.registerSingleton<ChangeNotifierProvider>(ChangeNotifierProvider(
    create: (_) => AppTheme(themeSettings),
  ));
  getIt.registerSingleton<HostnameService>(HostnameService());
  getIt.registerSingleton<PowerProfileService>(PowerProfileService());
  getIt.registerSingleton<BluetoothService>(BluetoothService());
  getIt.registerSingleton<PowerSettingsService>(PowerSettingsService());

  getIt.registerSingleton<UDisksClient>(UDisksClient());
  getIt.registerSingleton<UPowerClient>(UPowerClient());
  getIt.registerSingleton<BlueZClient>(BlueZClient());
  getIt.registerSingleton<InputSourceService>(InputSourceService());
  getIt.registerSingleton<AppTheme>(AppTheme(themeSettings));
  runApp(
    const UbuntuSettingsApp(),
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
      themeMode: GetIt.instance.get<AppTheme>().value,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
