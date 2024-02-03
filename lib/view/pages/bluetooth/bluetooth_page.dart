import 'package:bluez/bluez.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/bluetooth/bluetooth_device_row.dart';
import 'package:settings/view/pages/bluetooth/bluetooth_model.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});
  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.bluetoothPageTitle
              .toLowerCase()
              .contains(value.toLowerCase())
          : false;

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.bluetoothPageTitle);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BluetoothModel(getService<BlueZClient>()),
      child: const BluetoothPage(),
    );
  }

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  @override
  void initState() {
    final model = context.read<BluetoothModel>();
    model.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BluetoothModel>();
    return SettingsPage(
      children: [
        SizedBox(
          width: kDefaultWidth,
          child: YaruSwitchRow(
            trailingWidget: Text(
              model.powered
                  ? context.l10n.switchedOn
                  : context.l10n.switchedOff,
            ),
            value: model.powered,
            onChanged: model.setPowered,
          ),
        ),
        SettingsSection(
          width: kDefaultWidth,
          headline: Text(context.l10n.devices),
          headerWidget: Flexible(
            child: TextButton(
              onPressed: model.powered
                  ? () => model.discovering
                      ? model.stopDiscovery()
                      : model.startDiscovery()
                  : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  model.discovering
                      ? const SizedBox(
                          width: 10,
                          height: 10,
                          child: YaruCircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    model.discovering
                        ? context.l10n.bluetoothStopDiscovery
                        : context.l10n.bluetoothStartDiscovery,
                  ),
                ],
              ),
            ),
          ),
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: model.devices.length,
              itemBuilder: (context, index) {
                if (model.devices[index].name.isNotEmpty) {
                  return BluetoothDeviceRow.create(
                    context,
                    model.devices[index],
                    () async => model.removeDevice(model.devices[index]),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
