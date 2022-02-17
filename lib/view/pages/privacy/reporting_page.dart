import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/privacy/reporting_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class ReportingPage extends StatelessWidget {
  const ReportingPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => ChangeNotifierProvider(
        create: (_) => ReportingModel(
          context.read<SettingsService>(),
        ),
        child: const ReportingPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ReportingModel>();
    return YaruPage(children: [
      YaruSwitchRow(
        trailingWidget: const Text('Send error reports to Ubuntu'),
        value: model.reportTechnicalProblems,
        onChanged: (value) => model.reportTechnicalProblems = value,
      ),
      YaruSwitchRow(
        trailingWidget: const Text('Send software usage to Ubuntu'),
        value: model.sendSoftwareUsageStats,
        onChanged: (value) => model.sendSoftwareUsageStats = value,
      ),
    ]);
  }
}
