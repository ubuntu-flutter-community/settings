import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/keyboard/special_characters_model.dart';
import 'package:settings/view/pages/settings_simple_dialog.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SpecialCharactersSection extends StatelessWidget {
  const SpecialCharactersSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SpecialCharactersModel>();

    return SettingsSection(
      width: kDefaultWidth,
      headline: const Text('Special characters'),
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
            child: YaruTile(
              title: const Text('Compose Key'),
              trailing: Text(
                snapshot.hasData
                    ? model.composeOptionsToStringMap[snapshot.data]!
                    : '',
              ),
            ),
          ),
        ),
        FutureBuilder<Lv3Options?>(
          future: model.getLv3Options(),
          builder: (context, snapshot) => InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () => showDialog(
              context: context,
              builder: (_) => ChangeNotifierProvider.value(
                value: model,
                child: const _Lv3OptionsDialog(),
              ),
            ),
            child: YaruTile(
              title: const Text('Lv3 Key'),
              trailing: Text(
                snapshot.hasData
                    ? model.lv3OptionsToStringMap[snapshot.data]!
                    : 'Default Layout',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Lv3OptionsDialog extends StatelessWidget {
  const _Lv3OptionsDialog();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SpecialCharactersModel>();
    return FutureBuilder<Lv3Options?>(
      future: model.getLv3Options(),
      builder: (context, snapshot) => SettingsSimpleDialog(
        width: kDefaultWidth / 2,
        title: 'Lv3 Keys',
        closeIconData: YaruIcons.window_close,
        children: [
          YaruSwitchRow(
            trailingWidget: const Text('Use default value'),
            value: snapshot.data == null,
            onChanged: model.removeLV3Options,
          ),
          const Divider(),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            title: const Text('None'),
            leading: YaruRadio<Lv3Options>(
              value: Lv3Options.none,
              groupValue: snapshot.data,
              onChanged: (value) => model.setLv3Options(value!),
            ),
          ),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            title: const Text('Right Alt-Key'),
            leading: YaruRadio<Lv3Options>(
              value: Lv3Options.rightAlt,
              groupValue: snapshot.data,
              onChanged: (value) => model.setLv3Options(value!),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComposeOptionsDialog extends StatelessWidget {
  const _ComposeOptionsDialog();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SpecialCharactersModel>();
    return FutureBuilder<ComposeOptions>(
      future: model.getComposeOptions(),
      builder: (context, snapshot) => SettingsSimpleDialog(
        width: kDefaultWidth / 2,
        closeIconData: YaruIcons.window_close,
        title: 'Compose-Key',
        children: [
          for (final option in ComposeOptions.values)
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              title: Text(option.localize(context.l10n)),
              leading: YaruRadio<ComposeOptions>(
                value: option,
                groupValue: snapshot.data,
                onChanged: (value) => model.setComposeOptions(value!),
              ),
            ),
        ],
      ),
    );
  }
}
