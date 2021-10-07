import 'package:bluez/bluez.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/bluetooth/bluetooth_device_row.dart';
import 'package:settings/view/pages/bluetooth/bluetooth_model.dart';
import 'package:settings/view/widgets/settings_section.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BluetoothModel(client: context.read<BlueZClient>()),
      child: const BluetoothPage(),
    );
  }

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  late BluetoothModel model;

  @override
  void initState() {
    model = context.read<BluetoothModel>();
    model.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 500,
          child: SettingsSection(headline: 'Bluetooth devices', children: [
            ListView(
              shrinkWrap: true,
              children: model.devices
                  .map((e) => BluetoothDeviceRow(device: e))
                  .toList(),
            )
          ]),
        )
      ],
    );
  }
}
