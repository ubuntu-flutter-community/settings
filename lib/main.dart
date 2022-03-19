import 'package:bluez/bluez.dart';
import 'package:flutter/material.dart';
import 'package:nm/nm.dart';
import 'package:provider/provider.dart';
import 'package:settings/app.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/bluetooth_service.dart';
import 'package:settings/services/date_time_service.dart';
import 'package:settings/services/display/display_service.dart';
import 'package:settings/services/hostname_service.dart';
import 'package:settings/services/house_keeping_service.dart';
import 'package:settings/services/input_source_service.dart';
import 'package:settings/services/locale_service.dart';
import 'package:settings/services/power_profile_service.dart';
import 'package:settings/services/power_settings_service.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/app_theme.dart';
import 'package:udisks/udisks.dart';
import 'package:upower/upower.dart';
import 'package:yaru/yaru.dart';

void main() async {
  final themeSettings = Settings(schemaInterface);

  final networkManagerClient = NetworkManagerClient();
  await networkManagerClient.connect();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LightTheme(yaruLight)),
        ChangeNotifierProvider(create: (_) => DarkTheme(yaruDark)),
        ChangeNotifierProvider(create: (_) => LightGtkTheme('Yaru')),
        ChangeNotifierProvider(create: (_) => DarkGtkTheme('Yaru-dark')),
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
        ),
        Provider<InputSourceService>(
          create: (_) => InputSourceService(),
        ),
        Provider<HouseKeepingService>(
          create: (_) => HouseKeepingService(),
          dispose: (_, service) => service.dispose(),
        ),
        Provider<DateTimeService>(
          create: (_) => DateTimeService(),
          dispose: (_, service) => service.dispose(),
        ),
        Provider<LocaleService>(
          create: (_) => LocaleService(),
          dispose: (_, service) => service.dispose(),
        ),
        Provider<DisplayService>(
          create: (_) => DisplayService(),
          dispose: (_, DisplayService service) => service.dispose(),
        ),
      ],
      child: const UbuntuSettingsApp(),
    ),
  );
}
