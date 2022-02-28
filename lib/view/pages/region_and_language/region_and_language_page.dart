import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/locale_service.dart';
import 'package:settings/view/pages/region_and_language/region_and_language_model.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class RegionAndLanguagePage extends StatefulWidget {
  const RegionAndLanguagePage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => ChangeNotifierProvider(
        create: (context) => RegionAndLanguageModel(
            localeService: context.read<LocaleService>()),
        child: const RegionAndLanguagePage(),
      );

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.regionAndLanguagePageTitle);

  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.regionAndLanguagePageTitle
              .toLowerCase()
              .contains(value.toLowerCase())
          : false;

  @override
  State<RegionAndLanguagePage> createState() => _RegionAndLanguagePageState();
}

class _RegionAndLanguagePageState extends State<RegionAndLanguagePage> {
  @override
  void initState() {
    super.initState();
    context.read<RegionAndLanguageModel>().init();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<RegionAndLanguageModel>();
    return YaruPage(
      children: [
        YaruSection(width: kDefaultWidth, children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: YaruSingleInfoRow(
                infoLabel: 'Current language',
                infoValue: model.locale != null && model.locale!.first != null
                    ? model.locale!.first!
                    : ''),
          ),
          YaruRow(
              trailingWidget: const Text('Select a language'),
              actionWidget: YaruOptionButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) => ChangeNotifierProvider.value(
                            value: model,
                            child: const _LocaleSelectDialog(),
                          )),
                  iconData: YaruIcons.localization),
              enabled: true),
          YaruRow(
              trailingWidget: const Text('Manage and install languages'),
              actionWidget: YaruOptionButton(
                  onPressed: () => model.openGnomeLanguageSelector(),
                  iconData: YaruIcons.download),
              enabled: true),
        ])
      ],
    );
  }
}

class _LocaleSelectDialog extends StatelessWidget {
  const _LocaleSelectDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<RegionAndLanguageModel>();
    final title = model.locale != null && model.locale!.first != null
        ? model.locale!.first!
        : '';
    return SimpleDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      title: YaruDialogTitle(title: title),
      children: [
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
                    onPressed: () {},
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
