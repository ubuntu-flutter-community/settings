import 'dart:io';

import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/wallpaper/color_shading_option_row.dart';
import 'package:settings/view/pages/wallpaper/wallpaper_model.dart';
import 'package:settings/view/widgets/image_tile.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

class WallpaperPage extends StatelessWidget {
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
    final model = Provider.of<WallpaperModel>(context);

    return SettingsSection(headline: 'Set your wallpaper', children: [
      SettingsRow(
          trailingWidget: const Text('Background mode'),
          actionWidget: Row(
            children: [
              DropdownButton<bool>(
                  value: model.isColorBackground,
                  onChanged: (value) => model.colorBackground = value!,
                  items: const [
                    DropdownMenuItem(
                      child: Text('Colored background'),
                      value: true,
                    ),
                    DropdownMenuItem(
                      child: Text('Wallpaper'),
                      value: false,
                    ),
                  ]),
            ],
          )),
      if (model.isColorBackground)
        ColorShadingOptionRow(
          actionLabel: 'Color mode',
          onDropDownChanged: (value) {
            model.colorShadingType = value;
          },
          value: model.colorShadingType,
        ),
      SizedBox(
        width: 500,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: model.pictureUri.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 500,
                    height: 255,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: model.colorShadingType == ColorShadingType.solid
                            ? fromHex(model.primaryColor)
                            : null,
                        gradient:
                            model.colorShadingType == ColorShadingType.vertical
                                ? LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      fromHex(model.primaryColor),
                                      fromHex(model.secondaryColor),
                                    ],
                                  )
                                : model.colorShadingType ==
                                        ColorShadingType.horizontal
                                    ? LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          fromHex(model.primaryColor),
                                          fromHex(model.secondaryColor),
                                        ],
                                      )
                                    : null,
                      ),
                    ),
                  ),
                )
              : ImageTile(
                  path: model.pictureUri.replaceAll('file://', ''),
                  currentlySelected: false),
        ),
      ),
      FutureBuilder<List<String>>(
          future: model.preInstalledBackgrounds,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: 500,
                child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.6,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: OutlinedButton(
                              onPressed: () async {
                                final picPath = await openFilePicker(context);
                                if (null != picPath) {
                                  model.pictureUri = picPath;
                                }
                              },
                              child: const Icon(YaruIcons.plus),
                            ),
                          )
                        ] +
                        snapshot.data!
                            .map((picPathString) => ImageTile(
                                path: picPathString,
                                onTap: () => model.pictureUri = picPathString,
                                currentlySelected:
                                    model.pictureUri.contains(picPathString)))
                            .toList()),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.all(40.0),
                child: CircularProgressIndicator(),
              );
            }
          }),
      Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 10),
        child: SettingsRow(
            description: model.customWallpaperLocation,
            trailingWidget: const Text('Your own wallpaper collection'),
            actionWidget: SizedBox(
              width: 40,
              height: 40,
              child: OutlinedButton(
                style:
                    OutlinedButton.styleFrom(padding: const EdgeInsets.all(0)),
                onPressed: () async => model.customWallpaperLocation =
                    await openDirPicker(context),
                child: const Icon(YaruIcons.settings),
              ),
            )),
      ),
      model.customWallpaperLocation == null
          ? const Text('')
          : FutureBuilder<List<String>>(
              future: model.customBackgrounds,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    width: 500,
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.6,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: snapshot.data!
                          .map((picPathString) => ImageTile(
                              path: picPathString,
                              onTap: () => model.pictureUri = picPathString,
                              currentlySelected:
                                  model.pictureUri.contains(picPathString)))
                          .toList(),
                    ),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: CircularProgressIndicator(),
                  );
                }
              }),
    ]);
  }

  Future<String?> openDirPicker(BuildContext context) async {
    return await FilesystemPicker.open(
      title: 'Select your wallpaper location',
      context: context,
      rootDirectory: Directory('/home/'),
      fsType: FilesystemType.folder,
      pickText: 'Use this directory',
    );
  }

  Future<String?> openFilePicker(BuildContext context) async {
    return await FilesystemPicker.open(
        title: 'Select a wallpaper',
        allowedExtensions: ['.jpg', '.jpeg', '.png'],
        context: context,
        rootDirectory: Directory('/home/'),
        fsType: FilesystemType.file,
        pickText: 'Select a wallpaper',
        fileTileSelectMode: FileTileSelectMode.wholeTile);
  }

  Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
