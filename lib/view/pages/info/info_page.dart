import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/single_info_row.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';
import 'package:yaru/yaru.dart' as yaru;

import 'info_model.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({ Key? key }) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  void initState() {
    super.initState();

    final model = context.read<InfoModel>();
    model.init();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<InfoModel>();

    return Column(
      children: [
        const Icon(
          YaruIcons.ubuntu_logo,
          size: 128,
          color: yaru.Colors.orange
        ),

        const SizedBox(height: 10),

        Text(
          model.osName,
          style: Theme.of(context).textTheme.headline5
        ),

        const SizedBox(height: 30),
        
        SettingsSection(headline: 'Hardware', children: [
          SingleInfoRow(
            infoLabel: 'Processor',
            infoValue: model.processor,
          ),
          SingleInfoRow(
            infoLabel: 'Memory',
            infoValue: model.memory,
          ),
          SingleInfoRow(
            infoLabel: 'Graphics',
            infoValue: model.graphics,
          ),
          SingleInfoRow(
            infoLabel: 'Disk Capacity',
            infoValue: model.diskCapacity,
          ),
        ]),
        
        SettingsSection(headline: 'System', children: [
          SingleInfoRow(
            infoLabel: 'Hostname',
            infoValue: model.hostname,
          ),
          SingleInfoRow(
            infoLabel: 'OS name',
            infoValue: model.osName,
          ),
          SingleInfoRow(
            infoLabel: 'OS type',
            infoValue: model.osType,
          ),
          SingleInfoRow(
            infoLabel: 'Gnome version',
            infoValue: model.gnomeVersion,
          ),
          SingleInfoRow(
            infoLabel: 'Window server',
            infoValue: model.windowServer,
          ),
        ]),
      ],
    );
  }
}
