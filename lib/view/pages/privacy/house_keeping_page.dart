import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/house_keeping_service.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/privacy/privacy_model.dart';
import 'package:settings/view/section_description.dart';
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
        headline: context.l10n.houseKeepingRecentFilesHeadline,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SectionDescription(
                width: kDefaultWidth,
                text: context.l10n.houseKeepingRecentFilesDescription),
          ),
          YaruSwitchRow(
            enabled: model.rememberRecentFiles != null,
            trailingWidget:
                Text(context.l10n.houseKeepingRecentFilesRememberAction),
            value: model.rememberRecentFiles,
            onChanged: (value) => model.rememberRecentFiles = value,
          ),
          if (model.rememberRecentFiles != null &&
              model.rememberRecentFiles == true)
            YaruSwitchRow(
                enabled: model.recentFilesMaxAge != null,
                trailingWidget: Text(
                    context.l10n.houseKeepingRecentFilesRememberForeverAction),
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
                actionLabel: context.l10n.houseKeepingRecentFilesDaysAction,
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
        headline: context.l10n.houseKeepingTempTrashHeadline,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: SectionDescription(
                width: kDefaultWidth,
                text: context.l10n.houseKeepingTempTrashDescription),
          ),
          YaruSwitchRow(
            enabled: model.removeOldTempFiles != null,
            trailingWidget: Text(context.l10n.houseKeepingTempAutoRemoveAction),
            value: model.removeOldTempFiles,
            onChanged: (value) => model.removeOldTempFiles = value,
          ),
          YaruSwitchRow(
            enabled: model.removeOldTrashFiles != null,
            trailingWidget:
                Text(context.l10n.houseKeepingTrashAutoRemoveAction),
            value: model.removeOldTrashFiles,
            onChanged: (value) => model.removeOldTrashFiles = value,
          ),
          if (model.oldFilesAge != null && model.oldFilesAge?.toDouble() != -1)
            YaruSliderRow(
                enabled: model.oldFilesAge != null,
                actionLabel: context.l10n.houseKeepingTempTrashAutoDeleteDays,
                value: model.oldFilesAge?.toDouble() == -1
                    ? -1
                    : model.oldFilesAge?.toDouble(),
                min: 0,
                max: 30,
                onChanged: (value) => model.oldFilesAge = value.toInt()),
          SizedBox(
            width: kDefaultWidth,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      onPressed: () => showDialog(
                            context: context,
                            builder: (context) => _ConfirmationDialog(
                              title: context.l10n.houseKeepingEmptyTrash,
                              iconData: YaruIcons.trash_full,
                              onConfirm: () {
                                model.emptyTrash();
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                      child: Text(context.l10n.houseKeepingEmptyTrash,
                          style:
                              TextStyle(color: Theme.of(context).errorColor))),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: OutlinedButton(
                      onPressed: () => showDialog(
                            context: context,
                            builder: (context) => _ConfirmationDialog(
                              title: context.l10n.houseKeepingRemoveTempFiles,
                              iconData: YaruIcons.document,
                              onConfirm: () {
                                model.removeTempFiles();
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                      child: Text(context.l10n.houseKeepingRemoveTempFiles,
                          style:
                              TextStyle(color: Theme.of(context).errorColor))),
                ),
              ],
            ),
          ),
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
    return SimpleDialog(
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitle(
        mainAxisAlignment: MainAxisAlignment.center,
        closeIconData: YaruIcons.window_close,
        title: widget.title,
      ),
      contentPadding: EdgeInsets.zero,
      children: [
        Icon(
          widget.iconData,
          size: 100,
          color: colorAnimation.value,
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: kDefaultWidth / 3,
            child: Row(children: [
              Expanded(
                child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(context.l10n.cancel)),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: ElevatedButton(
                    onPressed: widget.onConfirm,
                    child: Text(
                      context.l10n.confirm,
                    )),
              )
            ]),
          ),
        )
      ],
    );
  }
}
