import 'package:bluez/bluez.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/bluetooth/bluetooth_device_row.dart';
import 'package:settings/view/pages/bluetooth/bluetooth_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class BluetoothPage extends StatefulWidget {
  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.bluetoothPageTitle
              .toLowerCase()
              .contains(value.toLowerCase())
          : false;

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.bluetoothPageTitle);

  const BluetoothPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BluetoothModel(context.read<BlueZClient>()),
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
    return YaruPage(
      children: [
        YaruSwitchRow(
            width: kDefaultWidth,
            trailingWidget: Text(model.powered
                ? context.l10n.switchedOn
                : context.l10n.switchedOff),
            value: model.powered,
            onChanged: (v) => model.setPowered(v)),
        YaruSection(
            width: kDefaultWidth,
            headline: context.l10n.devices,
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
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ))
                          : const SizedBox(),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(model.discovering
                          ? context.l10n.bluetoothStopDiscovery
                          : context.l10n.bluetoothStartDiscovery),
                    ],
                  )),
            ),
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: model.devices.length,
                itemBuilder: (context, index) => BluetoothDeviceRow.create(
                    context,
                    model.devices[index],
                    () async => model.removeDevice(model.devices[index])),
              )
            ]),
      ],
    );
  }
}
