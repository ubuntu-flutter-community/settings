import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/widgets/app_theme.dart';
import 'package:settings/view/widgets/option_card.dart';
import 'package:settings/view/widgets/settings_section.dart';

class ChoseYourLookSection extends StatelessWidget {
  const ChoseYourLookSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<AppTheme>();
    return SettingsSection(
      headline: 'Select a theme',
      children: [
        SizedBox(
          height: 300,
          child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: OptionCard(
                    imageAsset: 'assets/images/Theme_thumbnails-Light.png',
                    titleText: 'Light',
                    bodyText: 'Everything is bright and light',
                    selected: Theme.of(context).brightness == Brightness.light,
                    onSelected: () {
                      theme.apply(Brightness.light);
                    },
                  ),
                ),
                OptionCard(
                  imageAsset: 'assets/images/Theme_thumbnails-Dark.png',
                  titleText: 'Dark',
                  bodyText: 'Hello darkness my old friend',
                  selected: Theme.of(context).brightness == Brightness.dark,
                  onSelected: () => theme.apply(Brightness.dark),
                )
              ]),
        )
      ],
    );
  }
}
