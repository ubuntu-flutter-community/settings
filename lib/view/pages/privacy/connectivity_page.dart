import 'package:flutter/material.dart';
import 'package:nm/nm.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/privacy/connectivity_model.dart';
import 'package:settings/view/section_description.dart';
import 'package:yaru_settings/yaru_settings.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class ConnectivityPage extends StatefulWidget {
  const ConnectivityPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => ChangeNotifierProvider(
        create: (_) => ConnectivityModel(context.read<NetworkManagerClient>()),
        child: const ConnectivityPage(),
      );

  @override
  State<ConnectivityPage> createState() => _ConnectivityPageState();
}

class _ConnectivityPageState extends State<ConnectivityPage> {
  @override
  void initState() {
    final model = context.read<ConnectivityModel>();
    model.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ConnectivityModel>();
    return YaruPage(
      children: [
        SectionDescription(
          width: kDefaultWidth,
          text: context.l10n.checkConnectivityDescription,
        ),
        YaruSection(
          width: kDefaultWidth,
          children: [
            YaruSwitchRow(
              enabled: model.checkConnectiviy != null,
              trailingWidget: Text(context.l10n.checkConnectivityLabel),
              value: model.checkConnectiviy,
              onChanged: (v) => model.checkConnectiviy = v,
            ),
          ],
        ),
      ],
    );
  }
}
