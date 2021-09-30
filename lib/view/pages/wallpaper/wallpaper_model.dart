import 'dart:io';

import 'package:gsettings/gsettings.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class WallpaperModel extends SafeChangeNotifier {
  final GSettings? _wallpaperSettings;
  static const _pictureUriKey = 'picture-uri';
  static const _colorShadingTypeKey = 'color-shading-type';
  static const _drawBackgroundKey = 'draw-background';
  static const _pictureOpacityKey = 'picture-opacity';
  static const _pictureOptionsKey = 'picture-options';
  static const _primaryColorKey = 'primary-color';
  static const _secondaryColorKey = 'secondary-color';
  static const _showDesktopIconsKey = 'show-desktop-icons';
  static const _backgroundsDir = '/home/frederik/Bilder/BingWallpaper';

  WallpaperModel(SettingsService service)
      : _wallpaperSettings = service.lookup(schemaBackground);

  String get pictureUri => _wallpaperSettings!.stringValue(_pictureUriKey);

  set pictureUri(String uri) {
    _wallpaperSettings!.setValue(_pictureUriKey, uri);
    notifyListeners();
  }

  Future<List<String>> get backgrounds async {
    final dir = Directory(_backgroundsDir);
    final List<FileSystemEntity> entities = await dir.list().toList();
    final Iterable<File> files = entities.whereType<File>();
    return files.map((e) => e.path).toList();
  }
}
