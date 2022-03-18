import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/utils.dart';
import 'package:settings/view/pages/wallpaper/color_shading_option_row.dart';
import 'package:settings/view/pages/wallpaper/wallpaper_model.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class WallpaperPage extends StatelessWidget {
  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.wallpaperPageTitle);

  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.wallpaperPageTitle
              .toLowerCase()
              .contains(value.toLowerCase())
          : false;

  const WallpaperPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final service = Provider.of<SettingsService>(context, listen: false);
    return ChangeNotifierProvider<WallpaperModel>(
      create: (_) => WallpaperModel(service),
      child: const WallpaperPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WallpaperModel>();
    const headlineInsets =
        EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10);

    return YaruPage(
      children: [
        YaruRow(
            width: kDefaultWidth,
            enabled: true,
            trailingWidget: Text(context.l10n.wallpaperPageBackgroundModeLabel),
            actionWidget: Row(
              children: [
                DropdownButton<WallpaperMode>(
                    value: model.wallpaperMode,
                    onChanged: (value) => model.setWallpaperMode(value!),
                    items: [
                      DropdownMenuItem(
                        child: Text(context
                            .l10n.wallpaperPageBackgroundModeColoredBackground),
                        value: WallpaperMode.solid,
                      ),
                      DropdownMenuItem(
                        child: Text(
                            context.l10n.wallpaperPageBackgroundModeWallpaper),
                        value: WallpaperMode.custom,
                      ),
                      DropdownMenuItem(
                        child: Text(context
                            .l10n.wallpaperPageBackgroundModeImageOfTheDay),
                        value: WallpaperMode.imageOfTheDay,
                      ),
                    ]),
              ],
            )),
        if (model.wallpaperMode == WallpaperMode.solid)
          ColorShadingOptionRow(
            width: kDefaultWidth,
            actionLabel: context.l10n.wallpaperPageColorModeLabel,
            onDropDownChanged: (value) {
              model.colorShadingType = value;
            },
            value: model.colorShadingType,
          ),
        SizedBox(
          width: kDefaultWidth,
          child: model.pictureUri.isEmpty
              ? ChangeNotifierProvider.value(
                  value: model,
                  child: const _ColoredBackground(),
                )
              : YaruSelectableContainer(
                  child: _WallpaperImage(
                      path: model.pictureUri
                          .replaceAll(gnomeWallpaperSuffix, '')),
                  selected: false),
        ),
        if (model.wallpaperMode == WallpaperMode.imageOfTheDay)
          //TODO: Add the title and copyright info
          YaruRow(
            enabled: true,
            leadingWidget:
                Text(context.l10n.wallpaperPageBackgroundModeImageOfTheDay),
            trailingWidget: DropdownButton<ImageOfTheDayProvider>(
                value: model.imageOfTheDayProvider,
                onChanged: (value) => model.setUrlWallpaperProvider(value!),
                items: const [
                  DropdownMenuItem(
                    child: Text('Bing'),
                    value: ImageOfTheDayProvider.bing,
                  ),
                  DropdownMenuItem(
                    child: Text('Nasa'),
                    value: ImageOfTheDayProvider.nasa,
                  ),
                ]),
            actionWidget: YaruOptionButton(
              onPressed: () async {
                await model.refreshUrlWallpaper();
                if (model.errorMessage.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    model.errorMessage,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )));
                }
              },
              iconData: YaruIcons.refresh,
            ),
          ),
        if (model.wallpaperMode == WallpaperMode.custom)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: headlineInsets,
                child: Text(context.l10n.wallpaperPageYourWallpapersHeadline),
              ),
              FutureBuilder<List<String>?>(
                  future: model.customBackgrounds,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _WallpaperGrid(
                          data: snapshot.data!, customizableGrid: true);
                    } else {
                      return const _AddWallpaperTile();
                    }
                  }),
              Padding(
                padding: headlineInsets,
                child:
                    Text(context.l10n.wallpaperPageDefaultWallpapersHeadline),
              ),
              FutureBuilder<List<String>?>(
                  future: model.preInstalledBackgrounds,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _WallpaperGrid(
                          data: snapshot.data!, customizableGrid: false);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
      ],
    );
  }
}

class _WallpaperImage extends StatelessWidget {
  const _WallpaperImage({Key? key, required this.path, this.height})
      : super(key: key);

  final String path;
  final int? height;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(path),
      filterQuality: FilterQuality.none,
      fit: BoxFit.fill,
      cacheHeight: height,
    );
  }
}

class _AddWallpaperTile extends StatelessWidget {
  const _AddWallpaperTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<WallpaperModel>();
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () async {
          final picPath = await openFile(acceptedTypeGroups: [
            XTypeGroup(
              label: 'images',
              extensions: <String>['jpg', 'png'],
            )
          ]);
          if (null != picPath) {
            model.pictureUri = picPath.path;
            model.copyToCollection(picPath.path);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: const Icon(YaruIcons.plus),
            ),
          ),
        ),
      ),
    );
  }
}

class _WallpaperGrid extends StatelessWidget {
  const _WallpaperGrid(
      {Key? key, required this.data, required this.customizableGrid})
      : super(key: key);

  final List<String> data;
  final bool customizableGrid;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WallpaperModel>();

    return GridView(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 180,
        childAspectRatio: 16 / 10,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: <Widget>[
            if (customizableGrid)
              ChangeNotifierProvider.value(
                value: model,
                child: const _AddWallpaperTile(),
              )
          ] +
          data
              .map((picPathString) => Stack(
                    fit: StackFit.expand,
                    children: [
                      YaruSelectableContainer(
                          child:
                              _WallpaperImage(path: picPathString, height: 90),
                          onTap: () => model.pictureUri = picPathString,
                          selected: model.pictureUri.contains(picPathString)),
                      if (customizableGrid)
                        ChangeNotifierProvider.value(
                          value: model,
                          child: _RemoveWallpaperButton(path: picPathString),
                        ),
                    ],
                  ))
              .toList(),
    );
  }
}

class _RemoveWallpaperButton extends StatelessWidget {
  const _RemoveWallpaperButton({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    final model = context.read<WallpaperModel>();

    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          color: Theme.of(context).backgroundColor.withOpacity(0.9),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () => model.removeFromCollection(path),
          child: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(YaruIcons.window_close),
          ),
        ),
      ),
    );
  }
}

class _ColoredBackground extends StatelessWidget {
  const _ColoredBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WallpaperModel>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 300,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: model.colorShadingType == ColorShadingType.solid
                ? colorFromHex(model.primaryColor)
                : null,
            gradient: model.colorShadingType == ColorShadingType.vertical
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colorFromHex(model.primaryColor),
                      colorFromHex(model.secondaryColor),
                    ],
                  )
                : model.colorShadingType == ColorShadingType.horizontal
                    ? LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          colorFromHex(model.primaryColor),
                          colorFromHex(model.secondaryColor),
                        ],
                      )
                    : null,
          ),
        ),
      ),
    );
  }
}
