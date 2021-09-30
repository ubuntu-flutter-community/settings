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
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: snapshot.data!
                      .map((e) => InkWell(
                            borderRadius: BorderRadius.circular(8.0),
                            onTap: () => model.pictureUri = 'file://' + e,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: model.pictureUri.contains(e)
                                      ? Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.3)
                                      : Colors.transparent),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SizedBox(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6.0),
                                      child: Image.asset(
                                        e,
                                        width: 200,
                                      )),
                                ),
                              ),
                            ),
                          ))
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
