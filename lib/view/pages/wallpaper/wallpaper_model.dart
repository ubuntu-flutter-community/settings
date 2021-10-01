import 'dart:io';

import 'package:gsettings/gsettings.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class WallpaperModel extends SafeChangeNotifier {
  final GSettings? _wallpaperSettings;
  static const _pictureUriKey = 'picture-uri';
  static const _preinstalledWallpapersDir = '/usr/share/backgrounds';
  static const _homeWallpapers = '/home/frederik/Bilder';

  WallpaperModel(SettingsService service)
      : _wallpaperSettings = service.lookup(schemaBackground);

  String get pictureUri => _wallpaperSettings!.stringValue(_pictureUriKey);

  set pictureUri(String picPathString) {
    _wallpaperSettings!.setValue(_pictureUriKey, 'file://' + picPathString);
    notifyListeners();
  }

  Future<List<String>> get backgrounds async {
    final preDir = Directory(_preinstalledWallpapersDir);
    final List<FileSystemEntity> preEntities = await preDir.list().toList();
    final Iterable<File> preFiles = preEntities.whereType<File>();
    final preStringList = preFiles.map((e) => e.path).toList();

    final homeDir = Directory(_homeWallpapers);
    final List<FileSystemEntity> homeEntities = await homeDir.list().toList();
    final Iterable<File> homeFiles = homeEntities.whereType<File>();
    final homeStringList = homeFiles.map((e) => e.path).toList();

    return preStringList + homeStringList;
  }
}
