import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/locale_service.dart';
import 'package:settings/view/pages/region_and_language/region_and_language_model.dart';
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
        children: model.locale != null
            ? model.locale!
                .map((e) => ListTile(
                      title: Text(e!),
                    ))
                .toList()
            : []);
  }
}
