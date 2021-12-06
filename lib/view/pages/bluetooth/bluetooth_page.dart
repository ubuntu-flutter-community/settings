import 'package:bluez/bluez.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/bluetooth/bluetooth_device_row.dart';
import 'package:settings/view/pages/bluetooth/bluetooth_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class BluetoothPage extends StatefulWidget {
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
    model.startScan();
    super.initState();
  }

  @override
  void dispose() {
    final model = context.read<BluetoothModel>();
    model.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<BluetoothModel>(context, listen: true);
    List<Widget> deviceRows = [];
    return Column(
      children: [
        YaruSection(headline: 'Known devices', children: [
          FutureBuilder<List<BlueZDevice>>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                deviceRows = snapshot.data!.map((device) {
                  return BluetoothDeviceRow(device: device);
                }).toList();

                return ListView(
                  shrinkWrap: true,
                  children: deviceRows,
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
            future: model.devices,
          )
        ]),
        YaruSection(headline: 'New devices', children: [
          StreamBuilder<BlueZDevice>(
            stream: model.devicesAdded(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                BluetoothDeviceRow(
                  device: snapshot.data!,
                );
              }
              return const Padding(
                padding: EdgeInsets.all(28.0),
                child: CircularProgressIndicator(),
              );
            },
          )
        ]),
      ],
    );
  }
}
