import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:settings/view/widgets/app_theme.dart';
import 'package:settings/view/widgets/option_card.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<AppTheme>();
    return Center(
      child: SizedBox(
        height: 300,
        child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OptionCard(
                  imageAsset: 'assets/images/Theme_thumbnails-Dark.png',
                  titleText: 'Dark',
                  bodyText: 'Hello darkness my old friend',
                  selected: Theme.of(context).brightness == Brightness.dark,
                  onSelected: () => theme.apply(Brightness.dark),
                ),
              )
            ]),
      ),
    );
  }
}
