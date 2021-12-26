import 'dart:io';

import 'package:mime/mime.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WallpaperModel extends SafeChangeNotifier {
  final Settings? _wallpaperSettings;
  static const _pictureUriKey = 'picture-uri';
  static const _preinstalledWallpapersDir = '/usr/share/backgrounds';
  static const _colorShadingTypeKey = 'color-shading-type';
  static const _primaryColorKey = 'primary-color';
  static const _secondaryColorKey = 'secondary-color';

  //TODO: Sync the locale of the image with the device's locale
  static const String _bingImageAddress =
      'https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US';
  static const String _bingAddress = 'http://www.bing.com';

  WallpaperMode wallpaperMode = WallpaperMode.custom;

  final String? _userWallpapersDir =
      Platform.environment['HOME']! + '/.local/share/backgrounds/';

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

  Future<void> copyToCollection(String picPathString) async {
    File image = File(picPathString);
    await image
        .copy(_userWallpapersDir! + File(picPathString).uri.pathSegments.last);
    notifyListeners();
  }

  Future<List<String>> get preInstalledBackgrounds async {
    return (await getImages(_preinstalledWallpapersDir))
        .map((e) => e.path)
        .toList();
  }

  Future<List<String>> get customBackgrounds async {
    return (await getImages(_userWallpapersDir!)).map((e) => e.path).toList();
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

  Future<void> setWallpaperMode(WallpaperMode newWallpaperMode) async {
    wallpaperMode = newWallpaperMode;
    switch (wallpaperMode) {
      case WallpaperMode.solid:
        pictureUri = '';
        break;
      case WallpaperMode.custom:
        if (pictureUri.isEmpty) {
          _setFirstWallpaper();
        }
        break;
      case WallpaperMode.imageOfTheDay:
        refreshBingWallpaper();
        break;
    }

    notifyListeners();
  }

  void _setFirstWallpaper() async {
    final list = await preInstalledBackgrounds;
    pictureUri = list.first;
  }

  static Future<String> getBingImageUrl() async {
    http.Response imageMetadataResponse =
        await http.get(Uri.parse(_bingImageAddress));
    return _bingAddress +
        json.decode(imageMetadataResponse.body)['images'][0]['url'];
  }

  Future<void> refreshBingWallpaper() async {
    final Directory directory = await getApplicationDocumentsDirectory();

    final file = File('${directory.path}/bing.jpeg');

    // Refetch if the image doesn't exist or the current image is older than a day
    bool shouldRefetch =
        !file.existsSync() || file.lastModifiedSync().day != DateTime.now().day;

    if (shouldRefetch) {
      var imageResponse = await http.get(Uri.parse(await getBingImageUrl()));
      await file.writeAsBytes(imageResponse.bodyBytes);
    }

    pictureUri = '${directory.path}/bing.jpeg';
  }
}

enum ColorShadingType { solid, vertical, horizontal }

enum WallpaperMode { solid, custom, imageOfTheDay }
