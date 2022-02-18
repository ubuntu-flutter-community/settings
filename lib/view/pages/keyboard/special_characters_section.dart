import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/pages/keyboard/special_characters_model.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SpecialCharactersSection extends StatelessWidget {
  const SpecialCharactersSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SpecialCharactersModel>();

    return YaruSection(
        width: kDefaultWidth,
        headline: 'Special characters',
        children: [
          FutureBuilder<ComposeOptions>(
              future: model.getComposeOptions(),
              builder: (context, snapshot) => InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => ChangeNotifierProvider.value(
                        value: model,
                        child: const _ComposeOptionsDialog(),
                      ),
                    ),
                    child: YaruRow(
                      enabled: true,
                      trailingWidget: const Text('Compose Key'),
                      actionWidget: Text(snapshot.hasData
                          ? model.composeOptionsToStringMap[snapshot.data]!
                          : ''),
                    ),
                  )),
          FutureBuilder<Lv3Options?>(
            future: model.getLv3Options(),
            builder: (context, snapshot) => InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () => showDialog(
                  context: context,
                  builder: (_) => ChangeNotifierProvider.value(
                        value: model,
                        child: const _Lv3OptionsDialog(),
                      )),
              child: YaruRow(
                enabled: true,
                trailingWidget: const Text('Lv3 Key'),
                actionWidget: Text(snapshot.hasData
                    ? model.lv3OptionsToStringMap[snapshot.data]!
                    : 'Default Layout'),
              ),
            ),
          )
        ]);
  }
}

class _Lv3OptionsDialog extends StatelessWidget {
  const _Lv3OptionsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SpecialCharactersModel>();
    return FutureBuilder<Lv3Options?>(
      future: model.getLv3Options(),
      builder: (context, snapshot) => YaruSimpleDialog(
          width: kDefaultWidth / 2,
          title: 'Lv3 Keys',
          closeIconData: YaruIcons.window_close,
          children: [
            YaruSwitchRow(
                trailingWidget: const Text('Use default value'),
                value: snapshot.data == null,
                onChanged: (value) => model.removeLV3Options(value)),
            const Divider(),
            RadioListTile<Lv3Options>(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              title: const Text('None'),
              value: Lv3Options.none,
              groupValue: snapshot.data,
              onChanged: (value) => model.setLv3Options(value!),
            ),
            RadioListTile<Lv3Options>(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              title: const Text('Right Alt-Key'),
              value: Lv3Options.rightAlt,
              groupValue: snapshot.data,
              onChanged: (value) => model.setLv3Options(value!),
            ),
          ]),
    );
  }
}

class _ComposeOptionsDialog extends StatelessWidget {
  const _ComposeOptionsDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SpecialCharactersModel>();
    return FutureBuilder<ComposeOptions>(
      future: model.getComposeOptions(),
      builder: (context, snapshot) => YaruSimpleDialog(
        width: kDefaultWidth / 2,
        closeIconData: YaruIcons.window_close,
        title: 'Compose-Key',
        children: [
          RadioListTile<ComposeOptions>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            title: const Text('Default Layout'),
            value: ComposeOptions.defaultLayout,
            groupValue: snapshot.data,
            onChanged: (value) => model.setComposeOptions(value!),
          ),
          RadioListTile<ComposeOptions>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            title: const Text('Left Alt-Key'),
            value: ComposeOptions.leftAlt,
            groupValue: snapshot.data,
            onChanged: (value) => model.setComposeOptions(value!),
          ),
          RadioListTile<ComposeOptions>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            title: const Text('Right Alt-Key'),
            value: ComposeOptions.rightAlt,
            groupValue: snapshot.data,
            onChanged: (value) => model.setComposeOptions(value!),
          ),
          RadioListTile<ComposeOptions>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            title: const Text('Left Super-Key'),
            value: ComposeOptions.leftWin,
            groupValue: snapshot.data,
            onChanged: (value) => model.setComposeOptions(value!),
          ),
          RadioListTile<ComposeOptions>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            title: const Text('Right Super-Key'),
            value: ComposeOptions.rightWin,
            groupValue: snapshot.data,
            onChanged: (value) => model.setComposeOptions(value!),
          ),
          RadioListTile<ComposeOptions>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            title: const Text('Menu-Key'),
            value: ComposeOptions.menu,
            groupValue: snapshot.data,
            onChanged: (value) => model.setComposeOptions(value!),
          ),
          RadioListTile<ComposeOptions>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            title: const Text('Right Ctrl-Key'),
            value: ComposeOptions.rightCtrl,
            groupValue: snapshot.data,
            onChanged: (value) => model.setComposeOptions(value!),
          ),
          RadioListTile<ComposeOptions>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            title: const Text('Caps-Lock-Key'),
            value: ComposeOptions.caps,
            groupValue: snapshot.data,
            onChanged: (value) => model.setComposeOptions(value!),
          ),
          RadioListTile<ComposeOptions>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            title: const Text('Scroll-Lock-Key'),
            value: ComposeOptions.scrollLock,
            groupValue: snapshot.data,
            onChanged: (value) => model.setComposeOptions(value!),
          ),
          RadioListTile<ComposeOptions>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            title: const Text('Print Key'),
            value: ComposeOptions.print,
            groupValue: snapshot.data,
            onChanged: (value) => model.setComposeOptions(value!),
          )
        ],
      ),
    );
  }
}
