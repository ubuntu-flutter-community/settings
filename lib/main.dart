import 'package:bluez/bluez.dart';
import 'package:flutter/material.dart';
import 'package:linux_datetime_service/linux_datetime.dart';
import 'package:nm/nm.dart';
import 'package:settings/app.dart';
import 'package:settings/services/bluetooth_service.dart';
import 'package:settings/services/display/display_service.dart';
import 'package:settings/services/hostname_service.dart';
import 'package:settings/services/house_keeping_service.dart';
import 'package:settings/services/input_source_service.dart';
import 'package:settings/services/keyboard_service.dart';
import 'package:settings/services/locale_service.dart';
import 'package:settings/services/power_profile_service.dart';
import 'package:settings/services/power_settings_service.dart';
import 'package:udisks/udisks.dart';
import 'package:upower/upower.dart';
import 'package:watch_it/watch_it.dart';
import 'package:xdg_accounts/xdg_accounts.dart';
import 'package:yaru/yaru.dart';

void main() async {
  await YaruWindowTitleBar.ensureInitialized();

  final networkManagerClient = NetworkManagerClient();
  await networkManagerClient.connect();

  di
    ..registerLazySingleton<BluetoothService>(
      BluetoothService.new,
      dispose: (s) => s.dispose(),
    )
    ..registerLazySingleton<HostnameService>(
      HostnameService.new,
      dispose: (s) => s.dispose(),
    )
    ..registerLazySingleton<KeyboardService>(
      KeyboardMethodChannel.new,
    )
    ..registerLazySingleton<NetworkManagerClient>(() => networkManagerClient)
    ..registerLazySingleton<PowerProfileService>(
      PowerProfileService.new,
      dispose: (s) => s.dispose(),
    )
    ..registerLazySingleton<PowerGSettingsService>(
      PowerGSettingsService.new,
      dispose: (s) => s.dispose(),
    )
    ..registerLazySingleton<GSettingsService>(
      GSettingsService.new,
      dispose: (s) => s.dispose(),
    )
    ..registerLazySingleton<UDisksClient>(
      UDisksClient.new,
      dispose: (client) => client.close(),
    )
    ..registerLazySingleton<UPowerClient>(
      UPowerClient.new,
      dispose: (client) => client.close(),
    )
    ..registerLazySingleton<BlueZClient>(
      BlueZClient.new,
      dispose: (client) => client.close(),
    )
    ..registerLazySingleton<InputSourceService>(InputSourceService.new)
    ..registerLazySingleton<HouseKeepingService>(
      HouseKeepingService.new,
      dispose: (s) => s.dispose(),
    )
    ..registerLazySingleton<DateTimeService>(
      DateTimeService.new,
      dispose: (s) => s.dispose(),
    )
    ..registerLazySingleton<LocaleService>(
      LocaleService.new,
      dispose: (s) => s.dispose(),
    )
    ..registerLazySingleton<DisplayService>(
      DisplayService.new,
      dispose: (s) => s.dispose(),
    )
    ..registerLazySingleton<XdgAccounts>(
      XdgAccounts.new,
      dispose: (s) => s.dispose(),
    );

  runApp(const UbuntuSettingsApp());
}
