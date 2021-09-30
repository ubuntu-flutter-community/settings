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
      SizedBox(
        width: 500,
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () => {},
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.asset(
                  model.pictureUri.replaceAll('file://', ''),
                  width: 400,
                )),
          ),
        ),
      )
    ]);
  }
}
