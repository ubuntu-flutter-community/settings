import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/removable_media/removable_media_model.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class RemovableMediaPage extends StatelessWidget {
  const RemovableMediaPage({super.key});

  static Widget create(BuildContext context) =>
      ChangeNotifierProvider<RemovableMediaModel>(
        create: (_) => RemovableMediaModel(getService<SettingsService>()),
        child: const RemovableMediaPage(),
      );

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.removableMediaPageTitle);

  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.removableMediaPageTitle
              .toLowerCase()
              .contains(value.toLowerCase())
          : false;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<RemovableMediaModel>();

    return SettingsPage(
      children: [
        SizedBox(
          width: kDefaultWidth,
          child: YaruSwitchRow(
            trailingWidget: Text(context.l10n.removableMediaNeverAsk),
            value: model.autoRunNever,
            onChanged: (value) => model.autoRunNever = value,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        if (!model.autoRunNever)
          for (final mimeType in RemovableMediaModel.mimeTypes.entries)
            SizedBox(
              width: kDefaultWidth,
              child: YaruTile(
                enabled: model.mimeTypeBehavior != null,
                title: Text(mimeType.value),
                trailing: YaruPopupMenuButton<MimeTypeBehavior?>(
                  enabled: model.mimeTypeBehavior != null,
                  initialValue: model.getMimeTypeBehavior(mimeType.key),
                  itemBuilder: (p0) {
                    return [
                      for (final behavior in MimeTypeBehavior.values)
                        PopupMenuItem(
                          value: behavior,
                          onTap: () => model.setMimeTypeBehavior(
                            behavior,
                            mimeType.key,
                          ),
                          child: Text(
                            behavior.localize(context.l10n),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ];
                  },
                  child: Text(
                    model.getMimeTypeBehavior(mimeType.key) != null
                        ? model
                            .getMimeTypeBehavior(mimeType.key)!
                            .localize(context.l10n)
                        : '',
                  ),
                ),
              ),
            ),
      ],
    );
  }
}
