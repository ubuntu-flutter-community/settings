import 'dart:ffi';
import 'dart:io';
import 'package:dbus/dbus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/single_info_row.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';
import 'package:yaru/yaru.dart' as yaru;
import 'package:linux_system_info/linux_system_info.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({ Key? key }) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String _gpuName = "";
  String _hostname = "";

  final DBusRemoteObject _dBusRemoteObject = DBusRemoteObject(
    DBusClient.system(),
    name: 'org.freedesktop.hostname1',
    path: DBusObjectPath('/org/freedesktop/hostname1')
  );


  _InfoPageState() {
    GpuInfo.load().then((gpus) {
      setState(() {
        _gpuName = gpus.first.model;
      });
    });
    
    _dBusRemoteObject.getProperty('org.freedesktop.hostname1', 'Hostname').then((hostname) {
      setState(() {
        _hostname = hostname.toNative();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final String osNameVersion = SystemInfo().os_name + ' ' + SystemInfo().os_version;

    return Column(
      children: [
        const Icon(YaruIcons.ubuntu_logo, size: 128, color: yaru.Colors.orange),
        const SizedBox(height: 10),
        Text(osNameVersion, style: Theme.of(context).textTheme.headline5),
        const SizedBox(height: 30),
        SettingsSection(headline: 'Hardware', children: [
          SingleInfoRow(
            infoLabel: 'Processor',
            infoValue: CpuInfo.getProcessors()[0].model_name + ' x ' + (CpuInfo.getProcessors().length + 1).toString()
          ),
          SingleInfoRow(
            infoLabel: 'Memory',
            infoValue: MemInfo().mem_total_gb.toString() + ' Gb'
          ),
          SingleInfoRow(
            infoLabel: 'Graphics',
            infoValue: _gpuName
          ),
          const SingleInfoRow(infoLabel: 'Disk Capacity', infoValue: '1 To'),
        ]),
        SettingsSection(headline: 'System', children: [
          SingleInfoRow(
            infoLabel: 'Hostname',
            infoValue: _hostname
          ),
          SingleInfoRow(
            infoLabel: 'OS name',
            infoValue: osNameVersion
          ),
          SingleInfoRow(
            infoLabel: 'OS type',
            infoValue: sizeOf<IntPtr>() == 8 ? '64 bits' : '32 bits',
          ),
          SingleInfoRow(
            infoLabel: 'Gnome version',
            infoValue: GnomeInfo().version,
          ),
          SingleInfoRow(
            infoLabel: 'Window server',
            infoValue: Platform.environment['XDG_SESSION_TYPE'] ?? ''
          ),
        ]),
      ],
    );
  }
}
