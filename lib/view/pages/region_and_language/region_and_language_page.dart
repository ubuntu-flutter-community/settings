import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/locale_service.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/pages/region_and_language/region_and_language_model.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class RegionAndLanguagePage extends StatefulWidget {
  const RegionAndLanguagePage({super.key});

  static Widget create(BuildContext context) => ChangeNotifierProvider(
        create: (context) => RegionAndLanguageModel(
          localeService: getService<LocaleService>(),
        ),
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
    return SettingsPage(
      children: [
        SettingsSection(
          width: kDefaultWidth,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: YaruTile(
                title: Text(
                  context.l10n.regionAndLanguagePageSelectLanguageAction,
                ),
                trailing: OutlinedButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => ChangeNotifierProvider.value(
                      value: model,
                      child: const _LocaleSelectDialog(),
                    ),
                  ),
                  child: Text(
                    LocaleNames.of(context)!.nameOf(model.prettyLocale) ??
                        model.prettyLocale,
                  ),
                ),
              ),
            ),
            YaruTile(
              title:
                  Text(context.l10n.regionAndLanguagePageManageLanguageAction),
              trailing: YaruOptionButton(
                onPressed: model.openGnomeLanguageSelector,
                child: const Icon(YaruIcons.download),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LocaleSelectDialog extends StatefulWidget {
  const _LocaleSelectDialog();

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
    _selectedIndex = model.installedLocales.indexOf(
      model.installedLocales.firstWhere(
        (element) => model.locale.contains(element.replaceAll('utf8', 'UTF-8')),
      ),
    );
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
        title: YaruTitleBar(
          title: Text(
            model.locale.contains(localeToBeSet.replaceAll('utf8', 'UTF-8'))
                ? context.l10n.regionAndLanguagePageSelectLanguageAction
                : context.l10n.regionAndLanguageDialogTitleAfterChange,
          ),
        ),
        content: SizedBox(
          height: 500,
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                model.installedLocales.length,
                (index) => ListTile(
                  selected: _selectedIndex == index,
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    localeToBeSet = model.installedLocales[index];
                  },
                  title: Text(
                    LocaleNames.of(context)!
                            .nameOf(model.installedLocales[index]) ??
                        model.installedLocales[index],
                  ),
                ),
              ),
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
              child: Text(context.l10n.cancel),
            ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
