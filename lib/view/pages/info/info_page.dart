import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/widgets/settings_row.dart';
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

        const _Computer(),
        
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

class _Computer extends StatelessWidget {
  const _Computer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<InfoModel>(context);
    
    return SettingsSection(headline: 'Computer', children: [
      SettingsRow(
        actionLabel: 'Hostname',
        secondChild: Row(
          children: [
            Text(
              model.hostname,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
              ),
            ),
            const SizedBox(width: 16.0),
            SizedBox(
              width: 40,
              height: 40,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(0)),
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => ChangeNotifierProvider.value(
                    value: model,
                    child: const _HostnameSettings(),
                  ),
                ),
                child: const Icon(YaruIcons.settings),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}

class _HostnameSettings extends StatefulWidget {
  const _HostnameSettings({Key? key}) : super(key: key);

  @override
  State<_HostnameSettings> createState() => _HostnameSettingsState();
}

class _HostnameSettingsState extends State<_HostnameSettings> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    final model = context.read<InfoModel>();
    _controller.value = TextEditingValue(
      text: model.hostname,
      selection: TextSelection.collapsed(offset: model.hostname.length),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<InfoModel>();
    return SimpleDialog(
      title: const Center(child: Text('Edit hostname')),
      contentPadding: const EdgeInsets.all(16.0),
      children: [
        TextField(controller: _controller),

        const SizedBox(height: 16.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => model.setHostname(_controller.value.text),
              child: const Text('Rename'),
            )
          ],
        )
      ],
    );
  }
}
