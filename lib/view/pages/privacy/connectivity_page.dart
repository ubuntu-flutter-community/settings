import 'package:flutter/material.dart';
import 'package:nm/nm.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/pages/privacy/connectivity_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class ConnectivityPage extends StatefulWidget {
  const ConnectivityPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => ChangeNotifierProvider(
      create: (_) => ConnectivityModel(context.read<NetworkManagerClient>()),
      child: const ConnectivityPage());

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
    return YaruPage(children: [
      YaruSwitchRow(
        width: kDefaultWidth,
        enabled: model.checkConnectiviy != null,
        trailingWidget: const Text('Check Connectivity'),
        value: model.checkConnectiviy,
        onChanged: (v) => model.checkConnectiviy = v,
      )
    ]);
  }
}
