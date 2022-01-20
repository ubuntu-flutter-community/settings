import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/removable_media/removable_media_model.dart';
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

  @override
  Widget build(BuildContext context) {
    final model = context.watch<RemovableMediaModel>();

    return YaruPage(
      children: [
        YaruSection(
            width: kDefaultWidth,
            headline: 'Removable Media',
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8),
                child: YaruCheckboxRow(
                    enabled: true,
                    value: model.autoRunNever,
                    onChanged: (value) => model.autoRunNever = value!,
                    text:
                        'Never ask or start a program for any removable media'),
              ),
              if (!model.autoRunNever)
                for (var mimeType in RemovableMediaModel.mimeTypes.entries)
                  YaruRow(
                      enabled: !model.autoRunNever,
                      trailingWidget: Text(mimeType.value),
                      actionWidget: DropdownButton<String>(
                          value: model.getMimeTypeBehavior(mimeType.key),
                          onChanged: (string) =>
                              model.setMimeTypeBehavior(string!, mimeType.key),
                          items: [
                            for (var string
                                in RemovableMediaModel.mimeTypeBehaviors)
                              DropdownMenuItem(
                                  child: Text(string), value: string),
                          ])),
            ]),
      ],
    );
  }
}
