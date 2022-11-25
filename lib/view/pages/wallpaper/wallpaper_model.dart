import 'dart:io';

import 'package:mime/mime.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const gnomeWallpaperSuffix = 'file://';
const _gnomeUserWallpaperLocation = '/.local/share/backgrounds/';
const _bingApiUrl =
    'https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US';
const _bingUrl = 'http://www.bing.com';
const _nasaUrl =
    'https://api.nasa.gov/planetary/apod?api_key=PdQXYMNV2kT9atjMjNI9gbzLqe7qF6TcEHXhexXg';

class WallpaperModel extends SafeChangeNotifier {
  final Settings? _wallpaperSettings;
  static const _pictureUriKey = 'picture-uri';
  static const _pictureUriDarkKey = 'picture-uri-dark';

  static const _preinstalledWallpapersDir = '/usr/share/backgrounds';
  static const _colorShadingTypeKey = 'color-shading-type';
  static const _primaryColorKey = 'primary-color';
  static const _secondaryColorKey = 'secondary-color';
  String errorMessage = '';
  WallpaperMode wallpaperMode = WallpaperMode.custom;
  ImageOfTheDayProvider imageOfTheDayProvider = ImageOfTheDayProvider.bing;

  final String? _userWallpapersDir =
      Platform.environment['HOME']! + _gnomeUserWallpaperLocation;

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
      _wallpaperSettings?.stringValue(_pictureUriKey) ?? '';

  set pictureUri(String picPathString) {
    _wallpaperSettings?.setValue(
      _pictureUriKey,
      picPathString.isEmpty ? '' : gnomeWallpaperSuffix + picPathString,
    );
    notifyListeners();
  }

  String get pictureUriDark =>
      _wallpaperSettings?.stringValue(_pictureUriDarkKey) ?? '';

  set pictureUriDark(String picPathString) {
    _wallpaperSettings?.setValue(
      _pictureUriDarkKey,
      picPathString.isEmpty ? '' : gnomeWallpaperSuffix + picPathString,
    );
    notifyListeners();
  }

  Future<void> copyToCollection(String picPathString) async {
    File image = File(picPathString);
    if (_userWallpapersDir == null) return;
    await image
        .copy(_userWallpapersDir! + File(picPathString).uri.pathSegments.last);
    notifyListeners();
  }

  Future<void> removeFromCollection(String picPathString) async {
    final purePath = picPathString.replaceAll(gnomeWallpaperSuffix, '');
    File image = File(purePath);
    await image.delete();
    notifyListeners();
  }

  Future<List<String>?> get preInstalledBackgrounds async {
    return (await getImages(_preinstalledWallpapersDir))
        ?.map((e) => e.path)
        .toList();
  }

  Future<List<String>?> get customBackgrounds async {
    return (await getImages(_userWallpapersDir!))?.map((e) => e.path).toList();
  }

  Future<Iterable<File>?> getImages(String dir) async {
    return (await Directory(dir).list().toList())
        .whereType<File>()
        .where((element) => lookupMimeType(element.path)!.startsWith('image/'));
  }

  String get primaryColor =>
      _wallpaperSettings?.stringValue(_primaryColorKey) ?? '';

  set primaryColor(String colorHexValueString) {
    _wallpaperSettings?.setValue(_primaryColorKey, colorHexValueString);
    notifyListeners();
  }

  String get secondaryColor =>
      _wallpaperSettings?.stringValue(_secondaryColorKey) ?? '';

  set secondaryColor(String colorHexValueString) {
    _wallpaperSettings?.setValue(_secondaryColorKey, colorHexValueString);
    notifyListeners();
  }

  ColorShadingType get colorShadingType {
    final type = _wallpaperSettings?.stringValue(_colorShadingTypeKey);
    return type == 'solid'
        ? ColorShadingType.solid
        : type == 'vertical'
            ? ColorShadingType.vertical
            : ColorShadingType.horizontal;
  }

  set colorShadingType(ColorShadingType? colorShadingType) {
    switch (colorShadingType) {
      case ColorShadingType.horizontal:
        _wallpaperSettings?.setValue(_colorShadingTypeKey, 'horizontal');
        break;
      case ColorShadingType.vertical:
        _wallpaperSettings?.setValue(_colorShadingTypeKey, 'vertical');
        break;
      case ColorShadingType.solid:
        _wallpaperSettings?.setValue(_colorShadingTypeKey, 'solid');
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
        pictureUriDark = '';
        break;
      case WallpaperMode.custom:
        if (pictureUri.isEmpty) {
          _setFirstWallpaper();
        }
        break;
      case WallpaperMode.imageOfTheDay:
        setUrlWallpaperProvider(imageOfTheDayProvider);
        break;
    }

    notifyListeners();
  }

  void _setFirstWallpaper() async {
    final list = await preInstalledBackgrounds;
    pictureUri = list?.first ?? '';
  }

  Future<void> refreshUrlWallpaper() async {
    await setUrlWallpaperProvider(imageOfTheDayProvider);
  }

  Future<void> setUrlWallpaperProvider(
    ImageOfTheDayProvider newImageOfTheDayProvider,
  ) async {
    errorMessage = '';
    //Set the new provider
    imageOfTheDayProvider = newImageOfTheDayProvider;

    // Load the user's Documents Directory to store the downloaded wallpapers
    final directory = await getApplicationDocumentsDirectory();

    ImageProvider getProvider(ImageOfTheDayProvider providerName) {
      switch (providerName) {
        case ImageOfTheDayProvider.bing:
          {
            return ImageProvider(
              apiUrl: _bingApiUrl,
              getImageUrl: (json) {
                return _bingUrl + json['images'][0]['url'];
              },
              getImageMetadata: (json) =>
                  json['images'][0]['copyright'].replaceAll('/', ' - ') ??
                  '(© Bing)',
            );
          }
        case ImageOfTheDayProvider.nasa:
          {
            return ImageProvider(
              apiUrl: _nasaUrl,
              getImageUrl: (json) => json['hdurl'] ?? json['url'],
              getImageMetadata: (json) =>
                  '${json['title'] == null ? '' : json['title'] + ' '}(© ${json['copyright'] ?? 'NASA'})',
            );
          }
      }
    }

    //Get the url of the day using the apiUrl in the providers Map
    Future<ImageModel> getImageUrl() async {
      ImageProvider currentProvider = getProvider(imageOfTheDayProvider);
      http.Response imageMetadataResponse =
          await http.get(Uri.parse(currentProvider.apiUrl));
      var decodedJson = json.decode(imageMetadataResponse.body);
      return ImageModel(
        imageUrl: currentProvider.getImageUrl(decodedJson),
        imageMetadata: currentProvider.getImageMetadata(decodedJson),
      );
    }

    ImageModel image = await getImageUrl();

    //TODO: Save the images to a more suitable location
    String path =
        '${directory.path}/ImageOfTheDay/${imageOfTheDayProvider.name}/';
    bool exists = await Directory(path).exists();
    if (!exists) {
      await Directory(path).create(recursive: true);
    }
    //TODO: Embed the copyright info in the metadata instead of the filename
    final file = File(path + image.imageMetadata + '.jpeg');

    // Refetch if the image doesn't exist or the current image is older than a day
    if (!file.existsSync() ||
        file.lastModifiedSync().day != DateTime.now().day) {
      var imageResponse = await http.get(Uri.parse(image.imageUrl));
      await file.writeAsBytes(imageResponse.bodyBytes);
    }

    // Set the wallpaper to the downloaded image path
    pictureUri = file.path;
  }
}

class ImageProvider {
  final String apiUrl;
  final Function getImageUrl;
  final Function getImageMetadata;
  ImageProvider({
    required this.apiUrl,
    required this.getImageMetadata,
    required this.getImageUrl,
  });
}

class ImageModel {
  final String imageUrl;
  final String imageMetadata;
  ImageModel({
    required this.imageUrl,
    required this.imageMetadata,
  });
}

enum ColorShadingType {
  solid,
  vertical,
  horizontal;

  String localize(AppLocalizations l10n) {
    switch (this) {
      case ColorShadingType.solid:
        return l10n.wallpaperPageSolid;
      case ColorShadingType.vertical:
        return l10n.wallpaperPageHorizontalGradient;
      case ColorShadingType.horizontal:
        return l10n.wallpaperPageVerticalGradient;
    }
  }
}

enum WallpaperMode {
  solid,
  custom,
  imageOfTheDay;

  String localize(AppLocalizations l10n) {
    switch (this) {
      case WallpaperMode.solid:
        return l10n.wallpaperPageBackgroundModeColoredBackground;
      case WallpaperMode.custom:
        return l10n.wallpaperPageBackgroundModeWallpaper;
      case WallpaperMode.imageOfTheDay:
        return l10n.wallpaperPageBackgroundModeImageOfTheDay;
    }
  }
}

enum ImageOfTheDayProvider {
  bing,
  nasa;

  String localize(AppLocalizations l10n) {
    switch (this) {
      case bing:
        return 'Bing';
      case nasa:
        return 'Nasa';
    }
  }
}
