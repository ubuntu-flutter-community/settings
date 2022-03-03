import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
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
                infoValue:
                    LocaleNames.of(context)!.nameOf(model.prettyLocale) ??
                        model.prettyLocale),
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

class _LocaleSelectDialog extends StatefulWidget {
  const _LocaleSelectDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<_LocaleSelectDialog> createState() => _LocaleSelectDialogState();
}

class _LocaleSelectDialogState extends State<_LocaleSelectDialog> {
  late String localeToBeSet;
  late int _selectedIndex;
  @override
  void initState() {
    final model = context.read<RegionAndLanguageModel>();
    localeToBeSet = model.locale;
    _selectedIndex = model.installedLocales.indexOf(model.installedLocales
        .firstWhere((element) =>
            model.locale.contains(element.replaceAll('utf8', 'UTF-8'))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<RegionAndLanguageModel>();
    return SizedBox(
      width: kDefaultWidth / 2,
      child: AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: YaruDialogTitle(
            mainAxisAlignment: MainAxisAlignment.center,
            title:
                model.locale.contains(localeToBeSet.replaceAll('utf8', 'UTF-8'))
                    ? 'Select a language'
                    : 'Relog after save'),
        content: SizedBox(
          height: 500,
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                  model.installedLocales.length,
                  (index) => ListTile(
                        selected: _selectedIndex == index,
                        onTap: (() {
                          setState(() {
                            _selectedIndex = index;
                          });
                          localeToBeSet = model.installedLocales[index];
                        }),
                        title: Text(LocaleNames.of(context)!.nameOf(model
                                .installedLocales[index]
                                .replaceAll('.utf8', '')
                                .replaceAll('UTF-8', '')) ??
                            model.installedLocales[index]
                                .replaceAll('.utf8', '')
                                .replaceAll('.UTF-8', '')),
                      )),
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actionsOverflowButtonSpacing: 0,
        actions: [
          SizedBox(
            width: kDefaultWidth / 3,
            child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.l10n.cancel)),
          ),
          SizedBox(
            width: kDefaultWidth / 3,
            child: ElevatedButton(
                onPressed: () {
                  if (model.locale != localeToBeSet) {
                    model.locale = localeToBeSet;
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  context.l10n.confirm,
                )),
          )
        ],
      ),
    );
  }
}
