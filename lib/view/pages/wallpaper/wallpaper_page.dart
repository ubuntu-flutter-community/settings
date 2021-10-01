import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/pages/wallpaper/wallpaper_model.dart';
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
      FutureBuilder<List<String>>(
          future: model.backgrounds,
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
                      .map((picPathString) => WallpaperTile(
                          path: picPathString,
                          onTap: () => model.pictureUri = picPathString,
                          currentlySelected:
                              model.pictureUri.contains(picPathString)))
                      .toList(),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    ]);
  }
}

class WallpaperTile extends StatelessWidget {
  const WallpaperTile(
      {Key? key,
      required this.path,
      required this.onTap,
      required this.currentlySelected})
      : super(key: key);

  final String path;
  final bool currentlySelected;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: currentlySelected
                ? Theme.of(context).primaryColor.withOpacity(0.3)
                : Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ClipRRect(
              child: Image.file(
            File(path),
            filterQuality: FilterQuality.none,
            width: 50,
          )),
        ),
      ),
    );
  }
}
