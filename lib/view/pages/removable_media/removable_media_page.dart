import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/removable_media/removable_media_model.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:yaru_settings/yaru_settings.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class RemovableMediaPage extends StatelessWidget {
  const RemovableMediaPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final service = Provider.of<SettingsService>(context, listen: false);
    return ChangeNotifierProvider<RemovableMediaModel>(
      create: (_) => RemovableMediaModel(service),
      child: const RemovableMediaPage(),
    );
  }

  static Widget createTitle(BuildContext context) =>
      YaruPageItemTitle.text(context.l10n.removableMediaPageTitle);

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
          for (var mimeType in RemovableMediaModel.mimeTypes.entries)
            SizedBox(
              width: kDefaultWidth,
              child: YaruTile(
                enabled: !model.autoRunNever,
                title: Text(mimeType.value),
                trailing: DropdownButton<String>(
                  value: model.getMimeTypeBehavior(mimeType.key),
                  onChanged: (string) =>
                      model.setMimeTypeBehavior(string!, mimeType.key),
                  items: [
                    for (var string in RemovableMediaModel.mimeTypeBehaviors)
                      DropdownMenuItem(child: Text(string), value: string),
                  ],
                ),
              ),
            ),
      ],
    );
  }
}
