import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/services/house_keeping_service.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/privacy/privacy_model.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class HouseKeepingPage extends StatelessWidget {
  const HouseKeepingPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => ChangeNotifierProvider(
        create: (_) => PrivacyModel(context.read<SettingsService>(),
            context.read<HouseKeepingService>()),
        child: const HouseKeepingPage(),
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
                onChanged: (value) => model.oldFilesAge = value.toInt()),
          YaruRow(
              trailingWidget: const Text('Clean the house'),
              actionWidget: Row(
                children: [
                  OutlinedButton(
                      onPressed: () => showDialog(
                            context: context,
                            builder: (context) => _ConfirmationDialog(
                              title: 'Empty trash',
                              iconData: YaruIcons.trash_full,
                              onConfirm: () {
                                model.emptyTrash();
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                      child: Text('Empty Trash',
                          style:
                              TextStyle(color: Theme.of(context).errorColor))),
                  const SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                      onPressed: () => showDialog(
                            context: context,
                            builder: (context) => _ConfirmationDialog(
                              title: 'Remove Temp Files',
                              iconData: YaruIcons.document,
                              onConfirm: () {
                                model.removeTempFiles();
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                      child: Text('Remove Temp Files',
                          style:
                              TextStyle(color: Theme.of(context).errorColor))),
                ],
              ),
              enabled: true)
        ],
      ),
    ]);
  }
}

class _ConfirmationDialog extends StatefulWidget {
  const _ConfirmationDialog({
    Key? key,
    this.onConfirm,
    required this.iconData,
    this.title,
  }) : super(key: key);

  final Function()? onConfirm;
  final IconData iconData;
  final String? title;

  @override
  State<_ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<_ConfirmationDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation sizeAnimation;
  late Animation colorAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    sizeAnimation = Tween<double>(begin: 100.0, end: 400.0).animate(controller);
    colorAnimation =
        ColorTween(begin: Colors.red, end: Colors.red.withOpacity(0.2))
            .animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitle(
        title: widget.title,
      ),
      content: Icon(
        widget.iconData,
        size: 100,
        color: colorAnimation.value,
      ),
      contentPadding: const EdgeInsets.only(top: 20, bottom: 50),
      actions: [
        OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel')),
        OutlinedButton(
            onPressed: widget.onConfirm,
            child: Text(
              'Confirm',
              style: TextStyle(color: Theme.of(context).errorColor),
            ))
      ],
    );
  }
}
