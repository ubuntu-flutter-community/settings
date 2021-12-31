import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/keyboard/input_source_model.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SpecialCharactersSection extends StatelessWidget {
  const SpecialCharactersSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<InputSourceModel>();
    const composeKeyTitle = 'Compose-Key';
    const lv3KeyTitle = 'Key for special character';
    return YaruSection(headline: 'Special characters', children: [
      FutureBuilder<String>(
        future: model.getComposeKey(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? const SizedBox()
              : _SpecializedKeyRow(
                  title: composeKeyTitle,
                  keyLabel: snapshot.data ?? '',
                );
        },
      ),
      FutureBuilder<String>(
        future: model.getLv3Key(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? const SizedBox()
              : _SpecializedKeyRow(
                  title: lv3KeyTitle,
                  keyLabel: snapshot.data ?? '',
                );
        },
      )
    ]);
  }
}

class _SpecializedKeyRow extends StatelessWidget {
  const _SpecializedKeyRow({
    Key? key,
    required this.title,
    required this.keyLabel,
  }) : super(key: key);

  final String title;
  final String keyLabel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () => showDialog(
            context: context,
            builder: (context) => YaruSimpleDialog(
                  closeIconData: YaruIcons.window_close,
                  title: title,
                  children: [
                    YaruSwitchRow(
                        trailingWidget: const Text('Use default layout'),
                        value: true,
                        onChanged: (value) {}),
                    const Divider(),
                  ],
                )),
        child: YaruRow(
          trailingWidget: Text(title),
          actionWidget: Text(keyLabel),
        ));
  }
}
