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

    return YaruSection(headline: 'Special characters', children: [
      FutureBuilder<ComposeOptions>(
        future: model.getComposeOptions(),
        builder: (context, snapshot) {
          return InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () => showDialog(
                    context: context,
                    builder: (context) => YaruSimpleDialog(
                      closeIconData: YaruIcons.window_close,
                      title: 'Compose-Key',
                      children: [
                        RadioListTile<ComposeOptions>(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          title: const Text('Default Layout'),
                          value: ComposeOptions.defaultLayout,
                          groupValue: snapshot.data,
                          onChanged: (value) => model.setComposeOptions(value!),
                        ),
                        RadioListTile<ComposeOptions>(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          title: const Text('Left Alt-Key'),
                          value: ComposeOptions.leftAlt,
                          groupValue: snapshot.data,
                          onChanged: (value) => model.setComposeOptions(value!),
                        ),
                        RadioListTile<ComposeOptions>(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          title: const Text('Right Alt-Key'),
                          value: ComposeOptions.rightAlt,
                          groupValue: snapshot.data,
                          onChanged: (value) => model.setComposeOptions(value!),
                        ),
                        RadioListTile<ComposeOptions>(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          title: const Text('Left Super-Key'),
                          value: ComposeOptions.leftWin,
                          groupValue: snapshot.data,
                          onChanged: (value) => model.setComposeOptions(value!),
                        ),
                        RadioListTile<ComposeOptions>(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          title: const Text('Right Super-Key'),
                          value: ComposeOptions.rightWin,
                          groupValue: snapshot.data,
                          onChanged: (value) => model.setComposeOptions(value!),
                        ),
                        RadioListTile<ComposeOptions>(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          title: const Text('Menu-Key'),
                          value: ComposeOptions.menu,
                          groupValue: snapshot.data,
                          onChanged: (value) => model.setComposeOptions(value!),
                        ),
                        RadioListTile<ComposeOptions>(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          title: const Text('Right Ctrl-Key'),
                          value: ComposeOptions.rightCtrl,
                          groupValue: snapshot.data,
                          onChanged: (value) => model.setComposeOptions(value!),
                        ),
                        RadioListTile<ComposeOptions>(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          title: const Text('Caps-Lock-Key'),
                          value: ComposeOptions.caps,
                          groupValue: snapshot.data,
                          onChanged: (value) => model.setComposeOptions(value!),
                        ),
                        RadioListTile<ComposeOptions>(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          title: const Text('Scroll-Lock-Key'),
                          value: ComposeOptions.scrollLock,
                          groupValue: snapshot.data,
                          onChanged: (value) => model.setComposeOptions(value!),
                        ),
                        RadioListTile<ComposeOptions>(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          title: const Text('Print Key'),
                          value: ComposeOptions.print,
                          groupValue: snapshot.data,
                          onChanged: (value) => model.setComposeOptions(value!),
                        )
                      ],
                    ),
                  ),
              child: YaruRow(
                trailingWidget: const Text('Compose Key'),
                actionWidget: Text(snapshot.hasData
                    ? snapshot.data.toString()
                    : 'Default Layout'),
              ));
        },
      ),
      FutureBuilder<String>(
        future: model.getLv3Key(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? const SizedBox()
              : _SpecializedKeyRow(
                  title: 'Key for special character',
                  keyLabel: snapshot.data ?? '',
                  radioChildren: [],
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
    required this.radioChildren,
  }) : super(key: key);

  final String title;
  final String keyLabel;
  final List<Widget> radioChildren;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () => showDialog(
            context: context,
            builder: (context) => StatefulBuilder(
                  builder: (context, setState) => YaruSimpleDialog(
                    closeIconData: YaruIcons.window_close,
                    title: title,
                    children: radioChildren,
                  ),
                )),
        child: YaruRow(
          trailingWidget: Text(title),
          actionWidget: Text(keyLabel),
        ));
  }
}
