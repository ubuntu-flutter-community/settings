import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';
import 'package:nm/nm.dart';
import 'package:provider/provider.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/bluetooth_service.dart';
import 'package:settings/services/hostname_service.dart';
import 'package:settings/services/power_profile_service.dart';
import 'package:settings/services/power_settings_service.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/widgets/app_theme.dart';
import 'package:settings/view/widgets/master_details_page.dart';
import 'package:udisks/udisks.dart';
import 'package:upower/upower.dart';
import 'package:yaru/yaru.dart' as yaru;

void main() async {
  final themeSettings = GSettings(schemaId: schemaInterface);

  /// connect the client here until I found another
  /// solution tied to its page
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
        //HACK: not the right way to inject value with the provider , but that should help for now
        Provider<NetworkManagerClient>(
          create: (_) => networkManagerClient,
          dispose: (_, client) => client.close(),
        ),
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
