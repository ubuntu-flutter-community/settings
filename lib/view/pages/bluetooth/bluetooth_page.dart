import 'package:bluez/bluez.dart';
import 'package:flutter/material.dart';
import 'package:settings/view/widgets/settings_section.dart';

import 'bluetooth_device_row.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({Key? key}) : super(key: key);

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  late BlueZClient client;

  @override
  void initState() {
    client = BlueZClient();
    super.initState();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await client.close();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children;

    return Column(
      children: [
        SizedBox(
          width: 500,
          child: SettingsSection(headline: 'Bluetooth devices', children: [
            FutureBuilder<List<BlueZDevice>>(
                future: getDevices(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    children = snapshot.data!.map((device) {
                      return BluetoothDeviceRow(device: device);
                    }).toList();

                    return ListView(
                      shrinkWrap: true,
                      children: children,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })
          ]),
        )
      ],
    );
  }

  Future<List<BlueZDevice>> getDevices() async {
    await client.connect();

    return client.devices;
  }
}
