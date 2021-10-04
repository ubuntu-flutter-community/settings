import 'dart:io';

import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/wallpaper/wallpaper_model.dart';
import 'package:settings/view/widgets/file_picker_row.dart';
import 'package:settings/view/widgets/image_tile.dart';
import 'package:settings/view/widgets/settings_section.dart';

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

    return SettingsSection(headline: 'Wallpaper', children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 20, top: 20),
        child: FilePickerRow(
            label: 'Your wallpaper',
            onPressed: () async {
              final picPath = await openFilePicker(context);
              if (null != picPath) {
                model.pictureUri = picPath;
              }
            },
            pickingDescription: 'Browse'),
      ),
      SizedBox(
        width: 500,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: ImageTile(
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
      Padding(
        padding: const EdgeInsets.only(bottom: 20, top: 20),
        child: FilePickerRow(
            label: 'Your wallpaper location',
            onPressed: () async =>
                model.customWallpaperLocation = await openDirPicker(context),
            pickingDescription: 'Select a location'),
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
}
