import 'dart:io';

import 'package:gsettings/gsettings.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';
import 'package:mime/mime.dart';

class WallpaperModel extends SafeChangeNotifier {
  final GSettings? _wallpaperSettings;
  static const _pictureUriKey = 'picture-uri';
  static const _preinstalledWallpapersDir = '/usr/share/backgrounds';
  String? _customDir;

  WallpaperModel(SettingsService service)
      : _wallpaperSettings = service.lookup(schemaBackground);

  String get pictureUri => _wallpaperSettings!.stringValue(_pictureUriKey);

  set pictureUri(String picPathString) {
    _wallpaperSettings!.setValue(_pictureUriKey, 'file://' + picPathString);
    notifyListeners();
  }

  set customWallpaperLocation(String? path) {
    _customDir = path;
    notifyListeners();
  }

  String? get customWallpaperLocation => _customDir;

  Future<List<String>> get preInstalledBackgrounds async {
    return (await getImages(_preinstalledWallpapersDir))
        .map((e) => e.path)
        .toList();
  }

  Future<List<String>> get customBackgrounds async {
    return (await getImages(_customDir!)).map((e) => e.path).toList();
  }

  Future<Iterable<File>> getImages(String dir) async {
    final List<FileSystemEntity> preEntities =
        await Directory(dir).list().toList();
    final Iterable<File> preFiles = preEntities
        .whereType<File>()
        .where((element) => lookupMimeType(element.path)!.startsWith('image/'));
    return preFiles;
  }
}
