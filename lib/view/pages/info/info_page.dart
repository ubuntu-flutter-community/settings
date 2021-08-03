import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/single_info_row.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';
import 'package:yaru/yaru.dart' as yaru;
import 'package:linux_system_info/linux_system_info.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String osNameVersion = (SystemInfo().os_name ?? '') + ' ' + (SystemInfo().os_version ?? '');

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
          const SingleInfoRow(infoLabel: 'Graphics', infoValue: 'AMD Radeon R7 370'),
          const SingleInfoRow(infoLabel: 'Disk Capacity', infoValue: '1 To'),
        ]),
        SettingsSection(headline: 'System', children: [
          SingleInfoRow(
            infoLabel: 'OS name',
            infoValue: osNameVersion
          ),
          const SingleInfoRow(infoLabel: 'OS type', infoValue: '64-bit'),
        ]),
      ],
    );
  }
}
