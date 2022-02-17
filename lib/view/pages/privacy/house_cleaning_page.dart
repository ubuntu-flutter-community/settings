import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/privacy/privacy_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class HouseCleaningPage extends StatelessWidget {
  const HouseCleaningPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => ChangeNotifierProvider(
        create: (_) => PrivacyModel(context.read<SettingsService>()),
        child: const HouseCleaningPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PrivacyModel>();
    return YaruPage(children: [
      YaruSection(
        width: kDefaultWidth,
        headline: 'Recent Files History',
        children: [
          YaruSwitchRow(
            enabled: model.rememberRecentFiles != null,
            trailingWidget: const Text('Remember recent files'),
            value: model.rememberRecentFiles,
            onChanged: (value) => model.rememberRecentFiles = value,
          ),
          if (model.rememberRecentFiles != null &&
              model.rememberRecentFiles == true)
            YaruSwitchRow(
                enabled: model.recentFilesMaxAge != null,
                trailingWidget: const Text('Remember recent files forever'),
                value: model.recentFilesMaxAge?.toDouble() == -1,
                onChanged: (value) {
                  final intValue = value ? -1 : 1;
                  return model.recentFilesMaxAge = intValue;
                }),
          if (model.recentFilesMaxAge != null &&
              model.recentFilesMaxAge?.toDouble() != -1 &&
              model.rememberRecentFiles != null &&
              model.rememberRecentFiles == true)
            YaruSliderRow(
                enabled: model.recentFilesMaxAge != null,
                actionLabel: 'Days recorded',
                value: model.recentFilesMaxAge?.toDouble() == -1
                    ? -1
                    : model.recentFilesMaxAge?.toDouble(),
                min: -1,
                max: 30,
                onChanged: (value) => model.recentFilesMaxAge = value.toInt())
        ],
      ),
      YaruSection(
        width: kDefaultWidth,
        headline: 'Trash & Temp Files',
        children: [
          YaruSwitchRow(
            enabled: model.removeOldTempFiles != null,
            trailingWidget: const Text('Auto-remove old temp files'),
            value: model.removeOldTempFiles,
            onChanged: (value) => model.removeOldTempFiles = value,
          ),
          YaruSwitchRow(
            enabled: model.removeOldTrashFiles != null,
            trailingWidget: const Text('Auto-remove old trash files'),
            value: model.removeOldTrashFiles,
            onChanged: (value) => model.removeOldTrashFiles = value,
          ),
          if (model.oldFilesAge != null && model.oldFilesAge?.toDouble() != -1)
            YaruSliderRow(
                enabled: model.oldFilesAge != null,
                actionLabel: 'Days until auto-delete',
                value: model.oldFilesAge?.toDouble() == -1
                    ? -1
                    : model.oldFilesAge?.toDouble(),
                min: 0,
                max: 30,
                onChanged: (value) => model.oldFilesAge = value.toInt())
        ],
      ),
    ]);
  }
}
