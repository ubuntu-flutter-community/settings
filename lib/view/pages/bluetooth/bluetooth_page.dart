import 'package:bluez/bluez.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/bluetooth/bluetooth_device_row.dart';
import 'package:settings/view/pages/bluetooth/bluetooth_model.dart';
import 'package:settings/view/widgets/settings_section.dart';

class BluetoothPage extends StatelessWidget {
  const BluetoothPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BluetoothModel(client: context.read<BlueZClient>()),
      child: const BluetoothPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<BluetoothModel>();
    model.deviceStream().listen(
      (event) {
        print(event.address + event.name);
      },
    );
    List<Widget> children = [];
    return Column(
      children: [
        SizedBox(
          width: 500,
          child: SettingsSection(headline: 'Bluetooth devices', children: [
            FutureBuilder<List<BlueZDevice>>(
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
              },
              future: model.devices,
            )
          ]),
        ),
        SizedBox(
          width: 500,
          child: StreamBuilder<BlueZDevice>(
            stream: model.deviceStream(),
            builder: (context, deviceSnapshot) {
              if (deviceSnapshot.hasData) {
                children.add(BluetoothDeviceRow(device: deviceSnapshot.data!));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        )
      ],
    );
  }
}
