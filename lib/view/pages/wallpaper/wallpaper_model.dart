import 'dart:io';

import 'package:mime/mime.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class WallpaperModel extends SafeChangeNotifier {
  final Settings? _wallpaperSettings;
  static const _pictureUriKey = 'picture-uri';
  static const _preinstalledWallpapersDir = '/usr/share/backgrounds';
  static const _colorShadingTypeKey = 'color-shading-type';
  static const _primaryColorKey = 'primary-color';
  static const _secondaryColorKey = 'secondary-color';

  // TODO: store this outside of the app
  String? _customDir;

  WallpaperModel(SettingsService service)
      : _wallpaperSettings = service.lookup(schemaBackground) {
    _wallpaperSettings?.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _wallpaperSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  String get pictureUri =>
      _wallpaperSettings!.stringValue(_pictureUriKey) ?? '';

  set pictureUri(String picPathString) {
    _wallpaperSettings!.setValue(
        _pictureUriKey, picPathString.isEmpty ? '' : 'file://' + picPathString);
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
    return (await Directory(dir).list().toList())
        .whereType<File>()
        .where((element) => lookupMimeType(element.path)!.startsWith('image/'));
  }

  String get primaryColor =>
      _wallpaperSettings!.stringValue(_primaryColorKey) ?? '';

  set primaryColor(String colorHexValueString) {
    _wallpaperSettings!.setValue(_primaryColorKey, colorHexValueString);
    notifyListeners();
  }

  String get secondaryColor =>
      _wallpaperSettings!.stringValue(_secondaryColorKey) ?? '';

  set secondaryColor(String colorHexValueString) {
    _wallpaperSettings!.setValue(_secondaryColorKey, colorHexValueString);
    notifyListeners();
  }

  ColorShadingType get colorShadingType {
    final type = _wallpaperSettings!.stringValue(_colorShadingTypeKey);
    return type == 'solid'
        ? ColorShadingType.solid
        : type == 'vertical'
            ? ColorShadingType.vertical
            : ColorShadingType.horizontal;
  }

  set colorShadingType(ColorShadingType? colorShadingType) {
    switch (colorShadingType) {
      case ColorShadingType.horizontal:
        _wallpaperSettings!.setValue(_colorShadingTypeKey, 'horizontal');
        break;
      case ColorShadingType.vertical:
        _wallpaperSettings!.setValue(_colorShadingTypeKey, 'vertical');
        break;
      case ColorShadingType.solid:
        _wallpaperSettings!.setValue(_colorShadingTypeKey, 'solid');
        break;
      case null:
        return;
    }

    notifyListeners();
  }

  set colorBackground(bool value) {
    if (value) {
      pictureUri = '';
    } else {
      if (pictureUri.isEmpty) {
        _setFirstWallpaper();
      }
    }

    notifyListeners();
  }

  void _setFirstWallpaper() async {
    final list = await preInstalledBackgrounds;
    pictureUri = list.first;
  }

  bool get isColorBackground => pictureUri.isEmpty ? true : false;
}

enum ColorShadingType { solid, vertical, horizontal }
