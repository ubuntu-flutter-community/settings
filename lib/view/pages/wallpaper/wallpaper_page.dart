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
                      .map((e) => WallpaperTile(
                          path: e,
                          onTap: () => model.pictureUri = 'file://' + e,
                          currentlySelected: model.pictureUri.contains(e)))
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
              borderRadius: BorderRadius.circular(6.0),
              child: Image.asset(
                path,
                filterQuality: FilterQuality.none,
                width: 50,
              )),
        ),
      ),
    );
  }
}
