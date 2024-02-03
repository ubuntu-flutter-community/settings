import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/display/display_service.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/utils.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:settings/view/pages/wallpaper/color_shading_option_row.dart';
import 'package:settings/view/pages/wallpaper/wallpaper_model.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class WallpaperPage extends StatelessWidget {
  const WallpaperPage({super.key});
  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.wallpaperPageTitle);

  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.wallpaperPageTitle
              .toLowerCase()
              .contains(value.toLowerCase())
          : false;

  static Widget create(BuildContext context) =>
      ChangeNotifierProvider<WallpaperModel>(
        create: (_) => WallpaperModel(
          getService<SettingsService>(),
          getService<DisplayService>(),
        ),
        child: const WallpaperPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WallpaperModel>();

    const headlineInsets =
        EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10);

    final pictureUri = Theme.of(context).brightness == Brightness.light
        ? model.pictureUri
        : model.pictureUriDark;

    return SettingsPage(
      children: [
        SizedBox(
          width: kDefaultWidth,
          child: YaruTile(
            title: Text(context.l10n.wallpaperPageBackgroundModeLabel),
            trailing: Row(
              children: [
                YaruPopupMenuButton(
                  initialValue: model.wallpaperMode,
                  itemBuilder: (context) {
                    return [
                      for (final mode in WallpaperMode.values)
                        PopupMenuItem<WallpaperMode>(
                          value: mode,
                          onTap: () => model.setWallpaperMode(mode),
                          child: Text(mode.localize(context.l10n)),
                        ),
                    ];
                  },
                  child: Text(model.wallpaperMode.localize(context.l10n)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: kDefaultWidth,
          child: AspectRatio(
            aspectRatio: model.aspectRatio,
            child: pictureUri.isEmpty
                ? ChangeNotifierProvider.value(
                    value: model,
                    child: const _ColoredBackground(),
                  )
                : YaruSelectableContainer(
                    selected: false,
                    child: _WallpaperImage(
                      path: pictureUri.replaceAll(gnomeWallpaperSuffix, ''),
                    ),
                  ),
          ),
        ),
        if (model.wallpaperMode == WallpaperMode.solid)
          ColorShadingOptionRow(
            width: kDefaultWidth,
            actionLabel: context.l10n.wallpaperPageColorModeLabel,
            onDropDownChanged: (value) {
              model.colorShadingType = value;
            },
            value: model.colorShadingType,
          ),
        if (model.wallpaperMode == WallpaperMode.imageOfTheDay)
          Column(
            children: [
              SizedBox(
                width: kDefaultWidth,
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      model.caption,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: kDefaultWidth,
                child: YaruTile(
                  leading: Text(
                    context.l10n.wallpaperPageBackgroundModeImageOfTheDay,
                  ),
                  title: YaruPopupMenuButton<ImageOfTheDayProvider>(
                    initialValue: model.imageOfTheDayProvider,
                    itemBuilder: (context) {
                      return [
                        for (final provider in ImageOfTheDayProvider.values)
                          PopupMenuItem(
                            value: provider,
                            onTap: () =>
                                model.setUrlWallpaperProvider(provider),
                            child: Text(
                              provider.localize(context.l10n),
                            ),
                          ),
                      ];
                    },
                    child: Text(
                      model.imageOfTheDayProvider.localize(context.l10n),
                    ),
                  ),
                  trailing: YaruOptionButton(
                    onPressed: () async {
                      await model.refreshUrlWallpaper().then((_) {
                        if (model.errorMessage.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                model.errorMessage,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          );
                        }
                      });
                    },
                    child: const Icon(YaruIcons.refresh),
                  ),
                ),
              ),
            ],
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
                      data: snapshot.data!,
                      customizableGrid: true,
                    );
                  } else {
                    return const _AddWallpaperTile();
                  }
                },
              ),
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
                      data: snapshot.data!,
                      customizableGrid: false,
                    );
                  } else {
                    return const Center(
                      child: YaruCircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
      ],
    );
  }
}

class _WallpaperImage extends StatelessWidget {
  const _WallpaperImage({required this.path, this.height});

  final String path;
  final int? height;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(path),
      filterQuality: FilterQuality.none,
      fit: BoxFit.cover,
      cacheHeight: height,
    );
  }
}

class _AddWallpaperTile extends StatelessWidget {
  const _AddWallpaperTile();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final model = context.read<WallpaperModel>();
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () async {
          final picPath = await openFile(
            acceptedTypeGroups: [
              const XTypeGroup(
                label: 'images',
                extensions: <String>['jpg', 'png'],
              ),
            ],
          );
          if (null != picPath) {
            if (theme.brightness == Brightness.light) {
              model.pictureUri = picPath.path;
            } else {
              model.pictureUriDark = picPath.path;
            }
            await model.copyToCollection(picPath.path);
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

class _WallpaperGrid extends StatefulWidget {
  const _WallpaperGrid({
    required this.data,
    required this.customizableGrid,
  });

  final List<String> data;
  final bool customizableGrid;

  @override
  State<_WallpaperGrid> createState() => _WallpaperGridState();
}

class _WallpaperGridState extends State<_WallpaperGrid> {
  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WallpaperModel>();
    final pictureUri = Theme.of(context).brightness == Brightness.light
        ? model.pictureUri
        : model.pictureUriDark;

    return GridView(
      controller: _controller,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 180,
        childAspectRatio: 16 / 10,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: <Widget>[
            if (widget.customizableGrid)
              ChangeNotifierProvider.value(
                value: model,
                child: const _AddWallpaperTile(),
              ),
          ] +
          widget.data
              .map(
                (picPathString) => Stack(
                  fit: StackFit.expand,
                  children: [
                    YaruSelectableContainer(
                      onTap: () {
                        if (Theme.of(context).brightness == Brightness.light) {
                          model.pictureUri = picPathString;
                        } else {
                          model.pictureUriDark = picPathString;
                        }
                      },
                      selected: pictureUri.contains(picPathString),
                      child: _WallpaperImage(path: picPathString, height: 90),
                    ),
                    if (widget.customizableGrid)
                      ChangeNotifierProvider.value(
                        value: model,
                        child: _RemoveWallpaperButton(path: picPathString),
                      ),
                  ],
                ),
              )
              .toList(),
    );
  }
}

class _RemoveWallpaperButton extends StatelessWidget {
  const _RemoveWallpaperButton({
    required this.path,
  });

  final String path;

  @override
  Widget build(BuildContext context) {
    final model = context.read<WallpaperModel>();

    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          color: Theme.of(context).colorScheme.background.withOpacity(0.9),
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
  const _ColoredBackground();

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
