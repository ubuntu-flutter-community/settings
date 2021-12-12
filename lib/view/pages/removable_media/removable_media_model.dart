import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class RemovableMediaModel extends SafeChangeNotifier {
  static const mimeTypes = <String, String>{
    'x-content/audio-cdda': 'Audio CD',
    'x-content/video-dvd': 'DVD-Video',
    'x-content/audio-player': 'Musicplayer',
    'x-content/unix-software': 'Photos',
    'x-content/image-dcf': 'Applications',
    'x-content/audio-dvd': 'Audio DVD',
    'x-content/blank-bd': 'Blank BD',
    'x-content/blank-cd': 'Blank CD',
    'x-content/blank-dvd': 'Blank DVD',
    'x-content/blank-hddvd': 'Blank HD DVD',
    'x-content/ebook-reader': 'Ebook Reader',
    'x-content/image-picturecd': 'Image Picture CD',
    'x-content/ostree-repository': 'Ostree repository',
    'x-content/software': 'Software',
    'x-content/video-bluray': 'Video Blueray',
    'x-content/video-hddvd': 'Video HD DVD',
    'x-content/video-svcd': 'Video SV CD',
    'x-content/video-vcd': 'Video V CD',
    'x-content/win32-software': 'Windows Software'
  };

  static const mimeTypeBehaviors = [
    'Ignore',
    'Open Folder',
    'Start App',
    'Ask'
  ];

  final Settings? _removableMediaSettings;

  RemovableMediaModel(SettingsService service)
      : _removableMediaSettings = service.lookup(schemaMediaHandling) {
    _removableMediaSettings?.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _removableMediaSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  // autorun-never
  final _autoRunNeverKey = 'autorun-never';
  bool get autoRunNever =>
      _removableMediaSettings?.boolValue(_autoRunNeverKey) == true;
  set autoRunNever(bool value) {
    _removableMediaSettings!.setValue(_autoRunNeverKey, value);
    notifyListeners();
  }

  // autorun-x-content-ignore
  final _autoRunXContentIgnoreKey = 'autorun-x-content-ignore';
  List<String> _getAutoRunXContentIgnore() {
    final keys =
        _removableMediaSettings?.stringArrayValue(_autoRunXContentIgnoreKey);
    return keys?.whereType<String>().toList() ?? [];
  }

  void _setAutoRunXContentIgnore(List<String> value) {
    _removableMediaSettings!.setValue(_autoRunXContentIgnoreKey, value);
    notifyListeners();
  }

  // autorun-x-content-open-folder
  final _autoRunXContentOpenFolderKey = 'autorun-x-content-open-folder';
  List<String> _getAutoRunXContentOpenFolder() {
    final keys = _removableMediaSettings
        ?.stringArrayValue(_autoRunXContentOpenFolderKey);
    _removableMediaSettings!.stringArrayValue(_autoRunXContentOpenFolderKey);
    return keys?.whereType<String>().toList() ?? [];
  }

  void _setAutoRunXContentOpenFolder(List<String> value) {
    _removableMediaSettings!.setValue(_autoRunXContentOpenFolderKey, value);
    notifyListeners();
  }

  // autorun-x-content-start-app
  final _autoRunXContentStartAppKey = 'autorun-x-content-start-app';
  List<String> _getAutoRunXContentStartApp() {
    final keys =
        _removableMediaSettings?.stringArrayValue(_autoRunXContentStartAppKey);
    return keys?.whereType<String>().toList() ?? [];
  }

  void _setAutoRunXContentStartApp(List<String> value) {
    _removableMediaSettings!.setValue(_autoRunXContentStartAppKey, value);
    notifyListeners();
  }

  String getMimeTypeBehavior(String mimeType) {
    if (_getAutoRunXContentIgnore().contains(mimeType)) {
      return mimeTypeBehaviors[0];
    } else if (_getAutoRunXContentOpenFolder().contains(mimeType)) {
      return mimeTypeBehaviors[1];
    } else if (_getAutoRunXContentStartApp().contains(mimeType)) {
      return mimeTypeBehaviors[2];
    }
    return mimeTypeBehaviors[3];
  }

  void setMimeTypeBehavior(String string, String mimeType) {
    if (string == mimeTypeBehaviors[0]) {
      _addToIgnoreList(mimeType);
      _removeFromFolderList(mimeType);
      _removeFromAppStartList(mimeType);
    } else if (string == mimeTypeBehaviors[1]) {
      _addToFolderList(mimeType);
      _removeFromIgnoreList(mimeType);
      _removeFromAppStartList(mimeType);
    } else if (string == mimeTypeBehaviors[2]) {
      _addToAppStartList(mimeType);
      _removeFromIgnoreList(mimeType);
      _removeFromFolderList(mimeType);
    } else if (string == mimeTypeBehaviors[3]) {
      _removeFromIgnoreList(mimeType);
      _removeFromFolderList(mimeType);
      _removeFromAppStartList(mimeType);
    }
  }

  void _addToAppStartList(String mimeType) {
    final oldStartAppList = _getAutoRunXContentStartApp();
    oldStartAppList.add(mimeType);
    _setAutoRunXContentStartApp(oldStartAppList.toList());
  }

  void _removeFromIgnoreList(String mimeType) {
    final oldIgnoreList = _getAutoRunXContentIgnore();
    oldIgnoreList.remove(mimeType);
    _setAutoRunXContentIgnore(oldIgnoreList.toList());
  }

  void _addToFolderList(String mimeType) {
    final oldOpenFolderList = _getAutoRunXContentOpenFolder();
    oldOpenFolderList.add(mimeType);
    _setAutoRunXContentOpenFolder(oldOpenFolderList.toList());
  }

  void _removeFromAppStartList(String mimeType) {
    final oldStartAppList = _getAutoRunXContentStartApp();
    oldStartAppList.remove(mimeType);
    _setAutoRunXContentStartApp(oldStartAppList.toList());
  }

  void _removeFromFolderList(String mimeType) {
    final oldOpenFolderList = _getAutoRunXContentOpenFolder();
    oldOpenFolderList.remove(mimeType);
    _setAutoRunXContentOpenFolder(oldOpenFolderList.toList());
  }

  void _addToIgnoreList(String mimeType) {
    final oldIgnoreList = _getAutoRunXContentIgnore();
    oldIgnoreList.add(mimeType);
    _setAutoRunXContentIgnore(oldIgnoreList.toList());
  }
}

enum ContentHandling { ignore, openFolder, startApp, ask }
