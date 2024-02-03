import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/hostname_service.dart';
import 'package:settings/services/pdf_service.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/common/yaru_single_info_row.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:settings/view/pages/settings_simple_dialog.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:udisks/udisks.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'info_model.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<InfoModel>(
      create: (_) => InfoModel(
        hostnameService: getService<HostnameService>(),
        uDisksClient: getService<UDisksClient>(),
      ),
      child: const InfoPage(),
    );
  }

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.infoPageTitle);

  static bool searchMatches(String value, BuildContext context) => value
          .isNotEmpty
      ? context.l10n.infoPageTitle.toLowerCase().contains(value.toLowerCase())
      : false;

  @override
  State<InfoPage> createState() => _InfoPageState();
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
          await launchUrl(Uri.file('${dir.path}/System Data.pdf'));
        },
      ),
    );

    return SettingsPage(
      children: [
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (model.osName == 'Ubuntu')
              Stack(
                children: [
                  Positioned(
                    bottom: 10,
                    left: 25,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Icon(
                    YaruIcons.ubuntu_logo_large,
                    size: 100,
                    color: YaruColors.orange,
                  ),
                ],
              ),
            Text(
              model.osName,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
        const SizedBox(height: 50),
        const _Computer(),
        SettingsSection(
          width: kDefaultWidth,
          headline: const Text('Hardware'),
          children: [
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
              infoValue: model.graphics ?? 'No GPU info found',
            ),
            YaruSingleInfoRow(
              infoLabel: 'Disk Capacity',
              infoValue: model.diskCapacity != null
                  ? filesize(model.diskCapacity)
                  : '',
            ),
          ],
        ),
        SettingsSection(
          width: kDefaultWidth,
          headline: const Text('System'),
          children: [
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
          ],
        ),
        SizedBox(
          width: kDefaultWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                icon: const Icon(YaruIcons.save_as),
                label: const Text('Export to PDF'),
                onPressed: () async {
                  await PdfService.generateSystemData(
                    model.osName,
                    model.osVersion,
                    model.kernelVersion,
                    model.processorName,
                    model.processorCount.toString(),
                    model.memory.toString(),
                    model.graphics ?? 'No GPU info found',
                    model.diskCapacity != null
                        ? filesize(model.diskCapacity)
                        : '',
                    model.osType.toString(),
                    model.gnomeVersion,
                    model.windowServer,
                  ).then(
                    (value) => ScaffoldMessenger.of(context)
                        .showSnackBar(sysInfoSnackBar),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Computer extends StatelessWidget {
  const _Computer();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<InfoModel>();

    return SettingsSection(
      width: kDefaultWidth,
      headline: const Text('Computer'),
      children: [
        YaruTile(
          title: const Text('Hostname'),
          trailing: Row(
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
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => ChangeNotifierProvider.value(
                      value: model,
                      child: const _HostnameSettings(),
                    ),
                  ),
                  child: const Icon(YaruIcons.gear),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HostnameSettings extends StatefulWidget {
  const _HostnameSettings();

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
    return SettingsSimpleDialog(
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
            ),
          ],
        ),
      ],
    );
  }
}
