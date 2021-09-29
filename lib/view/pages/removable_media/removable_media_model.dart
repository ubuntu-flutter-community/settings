import 'package:gsettings/gsettings.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';

class RemovableMediaModel extends SafeChangeNotifier {
  static const mimeTypeSuffix = 'x-content/';
  static const ostreeRepository = mimeTypeSuffix + 'ostree-repository';
  static const audioCdda = mimeTypeSuffix + 'audio-cdda';
  static const videoDvd = mimeTypeSuffix + 'video-dvd';
  static const audioPlayer = mimeTypeSuffix + 'audio-player';
  static const unixSoftware = mimeTypeSuffix + 'unix-software';
  static const imageDcf = mimeTypeSuffix + 'image-dcf';

  final _removableMediaSettings =
      GSettingsSchema.lookup(schemaMediaHandling) != null
          ? GSettings(schemaId: schemaMediaHandling)
          : null;

  // autorun-never
  final _autoRunNeverKey = 'autorun-never';
  bool get autoRunNever => _removableMediaSettings!.boolValue(_autoRunNeverKey);
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

  List<bool>? getStartup(String mimeType) {
    return [
      _getAutoRunXContentIgnore().contains(mimeType),
      _getAutoRunXContentOpenFolder().contains(mimeType),
      _getAutoRunXContentStartApp().contains(mimeType),
      !_getAutoRunXContentIgnore().contains(mimeType) &&
          !_getAutoRunXContentOpenFolder().contains(mimeType) &&
          !_getAutoRunXContentStartApp().contains(mimeType)
    ];
  }

  void setStartup(int value, String mimeType) {
    switch (value) {
      case 0:
        _addToIgnoreList(mimeType);
        _removeFromFolderList(mimeType);
        _removeFromAppStartList(mimeType);
        break;
      case 1:
        _addToFolderList(mimeType);
        _removeFromIgnoreList(mimeType);
        _removeFromAppStartList(mimeType);
        break;
      case 2:
        _addToAppStartList(mimeType);
        _removeFromIgnoreList(mimeType);
        _removeFromFolderList(mimeType);
        break;
      case 3:
        _removeFromIgnoreList(mimeType);
        _removeFromFolderList(mimeType);
        _removeFromAppStartList(mimeType);
        break;
      default:
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

  @override
  void dispose() {
    _removableMediaSettings?.dispose();
    super.dispose();
  }
}
