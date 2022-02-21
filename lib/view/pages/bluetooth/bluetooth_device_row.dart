import 'package:bluez/bluez.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/bluetooth/bluetooth_device_model.dart';
import 'package:settings/view/pages/bluetooth/bluetooth_device_types.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';
import 'package:settings/l10n/l10n.dart';

class BluetoothDeviceRow extends StatefulWidget {
  const BluetoothDeviceRow({Key? key, required this.removeDevice})
      : super(key: key);

  final AsyncCallback removeDevice;

  static Widget create(
      BuildContext context, BlueZDevice device, AsyncCallback removeDevice) {
    return ChangeNotifierProvider(
      create: (_) => BluetoothDeviceModel(device),
      child: BluetoothDeviceRow(
        removeDevice: removeDevice,
      ),
    );
  }

  @override
  State<BluetoothDeviceRow> createState() => _BluetoothDeviceRowState();
}

class _BluetoothDeviceRowState extends State<BluetoothDeviceRow> {
  late String status;

  @override
  void initState() {
    final model = context.read<BluetoothDeviceModel>();
    model.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BluetoothDeviceModel>();
    return InkWell(
      borderRadius: BorderRadius.circular(4.0),
      onTap: () => showDialog(
          context: context,
          builder: (context) => ChangeNotifierProvider.value(
                value: model,
                child: _BluetoothDeviceDialog(
                  removeDevice: widget.removeDevice,
                ),
              )),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4, top: 4),
        child: YaruRow(
            enabled: true,
            trailingWidget: Text(model.name),
            actionWidget: Text(
              model.connected
                  ? context.l10n.connected.toLowerCase()
                  : context.l10n.disonnected.toLowerCase(),
              style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
            )),
      ),
    );
  }
}

class _BluetoothDeviceDialog extends StatelessWidget {
  const _BluetoothDeviceDialog({Key? key, required this.removeDevice})
      : super(key: key);

  final Function() removeDevice;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BluetoothDeviceModel>();
    return SimpleDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      title: YaruDialogTitle(
        closeIconData: YaruIcons.window_close,
        title: model.name,
        titleWidget: Icon(
            BluetoothDeviceTypes.getIconForAppearanceCode(model.appearance)),
      ),
      children: [
        YaruRow(
            enabled: true,
            trailingWidget: model.connected
                ? Text(context.l10n.connected)
                : Text(context.l10n.disonnected),
            actionWidget: Switch(
                value: model.connected,
                onChanged: (connectRequested) async {
                  connectRequested
                      ? await model.connect()
                      : await model.disconnect();
                })),
        YaruRow(
            enabled: true,
            trailingWidget: Text(context.l10n.paired),
            actionWidget: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(model.paired ? context.l10n.yes : context.l10n.no),
            )),
        YaruRow(
            enabled: true,
            trailingWidget: Text(context.l10n.address),
            actionWidget: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(model.address),
            )),
        YaruRow(
            enabled: true,
            trailingWidget: Text(context.l10n.type),
            actionWidget: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(BluetoothDeviceTypes.map[model.appearance] ??
                  context.l10n.unknown),
            )),
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8, right: 8, left: 8),
          child: SizedBox(
            width: 300,
            child: OutlinedButton(
                onPressed: () {
                  if (BluetoothDeviceTypes.isMouse(model.appearance)) {
                    // TODO: get route name from model
                    Navigator.of(context).pushNamed('routeName');
                  }
                },
                child: Text(context.l10n.bluetoothOpenDeviceSettings)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            width: 300,
            child: TextButton(
                onPressed: () async {
                  await model.disconnect();
                  removeDevice();
                  Navigator.of(context).pop();
                },
                child: Text(context.l10n.bluetoothRemoveDevice)),
          ),
        ),
        if (model.errorMessage.isNotEmpty)
          Text(
            model.errorMessage,
            style: TextStyle(color: Theme.of(context).errorColor),
          )
      ],
    );
  }
}
