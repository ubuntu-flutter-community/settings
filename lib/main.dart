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
import 'package:settings/services/settings_service.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:udisks/udisks.dart';
import 'package:upower/upower.dart';
import 'package:xdg_accounts/xdg_accounts.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

void main() async {
  await YaruWindowTitleBar.ensureInitialized();

  final networkManagerClient = NetworkManagerClient();
  await networkManagerClient.connect();

  registerService<BluetoothService>(
    BluetoothService.new,
    dispose: (s) => s.dispose(),
  );
  registerService<HostnameService>(
    HostnameService.new,
    dispose: (s) => s.dispose(),
  );
  registerService<KeyboardService>(
    KeyboardMethodChannel.new,
  );
  registerService<NetworkManagerClient>(() => networkManagerClient);
  registerService<PowerProfileService>(
    PowerProfileService.new,
    dispose: (s) => s.dispose(),
  );
  registerService<PowerSettingsService>(
    PowerSettingsService.new,
    dispose: (s) => s.dispose(),
  );
  registerService<SettingsService>(
    SettingsService.new,
    dispose: (s) => s.dispose(),
  );
  registerService<UDisksClient>(
    UDisksClient.new,
    dispose: (client) => client.close(),
  );
  registerService<UPowerClient>(
    UPowerClient.new,
    dispose: (client) => client.close(),
  );
  registerService<BlueZClient>(
    BlueZClient.new,
    dispose: (client) => client.close(),
  );
  registerService<InputSourceService>(InputSourceService.new);
  registerService<HouseKeepingService>(
    HouseKeepingService.new,
    dispose: (s) => s.dispose(),
  );
  registerService<DateTimeService>(
    DateTimeService.new,
    dispose: (s) => s.dispose(),
  );
  registerService<LocaleService>(
    LocaleService.new,
    dispose: (s) => s.dispose(),
  );
  registerService<DisplayService>(
    DisplayService.new,
    dispose: (s) => s.dispose(),
  );
  registerService<XdgAccounts>(
    XdgAccounts.new,
    dispose: (s) => s.dispose(),
  );

  runApp(const UbuntuSettingsApp());
}
