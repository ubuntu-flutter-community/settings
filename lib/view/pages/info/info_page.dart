import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:settings/api/pdf_api.dart';
import 'package:settings/constants.dart';
import 'package:settings/services/hostname_service.dart';
import 'package:udisks/udisks.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'info_model.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<InfoModel>(
      create: (_) => InfoModel(
        hostnameService: context.read<HostnameService>(),
        uDisksClient: context.read<UDisksClient>(),
      ),
      child: const InfoPage(),
    );
  }

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
    final sysInfoSnackBar = SnackBar(
      content: const Text('System Data Saved as PDF in Document Folder'),
      action: SnackBarAction(
        label: 'Open File',
        onPressed: () async {
          final dir = await getApplicationDocumentsDirectory();
          OpenFile.open('${dir.path}/System Data.pdf');
        },
      ),
    );

    return YaruPage(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // inner circle color
              ), // inner content
            ),
            const SizedBox(
                height: 128,
                width: 128,
                child: RiveAnimation.asset('assets/rive/ubuntu_cof.riv')),
          ],
        ),
        const SizedBox(height: 10),
        Text('${model.osName} ${model.osVersion}',
            style: Theme.of(context).textTheme.headline5),
        const SizedBox(height: 10),
        const SizedBox(height: 30),
        const _Computer(),
        YaruSection(width: kDefaultWidth, headline: 'Hardware', children: [
          YaruSingleInfoRow(
            infoLabel: 'Processor',
            infoValue: '${model.processorName} x ${model.processorCount}',
          ),
          YaruSingleInfoRow(
            infoLabel: 'Memory',
            infoValue: '${model.memory} Gb',
          ),
          YaruSingleInfoRow(
            infoLabel: 'Graphics',
            infoValue: model.graphics,
          ),
          YaruSingleInfoRow(
            infoLabel: 'Disk Capacity',
            infoValue:
                model.diskCapacity != null ? filesize(model.diskCapacity) : '',
          ),
        ]),
        YaruSection(width: kDefaultWidth, headline: 'System', children: [
          YaruSingleInfoRow(
            infoLabel: 'OS',
            infoValue:
                '${model.osName} ${model.osVersion} (${model.osType}-bit)',
          ),
          YaruSingleInfoRow(
            infoLabel: 'Kernel version',
            infoValue: model.kernelVersion,
          ),
          YaruSingleInfoRow(
            infoLabel: 'GNOME version',
            infoValue: model.gnomeVersion,
          ),
          YaruSingleInfoRow(
            infoLabel: 'Windowing System',
            infoValue: model.windowServer,
          ),
        ]),
        SizedBox(
          width: kDefaultWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                icon: const Icon(YaruIcons.save_as),
                label: const Text('Export to PDF'),
                onPressed: () async {
                  // ignore: unused_local_variable
                  final pdfFile = await PdfApi.generateSystemData(
                    model.osName,
                    model.osVersion,
                    model.kernelVersion,
                    model.processorName,
                    model.processorCount.toString(),
                    model.memory.toString(),
                    model.graphics,
                    model.diskCapacity != null
                        ? filesize(model.diskCapacity)
                        : '',
                    model.osType.toString(),
                    model.gnomeVersion,
                    model.windowServer,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sysInfoSnackBar);
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _Computer extends StatelessWidget {
  const _Computer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<InfoModel>();

    return YaruSection(width: kDefaultWidth, headline: 'Computer', children: [
      YaruRow(
        enabled: true,
        trailingWidget: const Text('Hostname'),
        actionWidget: Row(
          children: [
            SelectableText(
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
                style:
                    OutlinedButton.styleFrom(padding: const EdgeInsets.all(0)),
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
    return YaruSimpleDialog(
      width: kDefaultWidth / 2,
      title: 'Edit Hostname',
      closeIconData: YaruIcons.window_close,
      children: [
        TextField(
          autofocus: true,
          controller: _controller,
          decoration: const InputDecoration(border: UnderlineInputBorder()),
        ),
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
