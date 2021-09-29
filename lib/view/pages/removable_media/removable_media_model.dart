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

  // Audio CD
  List<bool>? get getAudioStartup {
    return [
      _getAutoRunXContentIgnore().contains(audioCdda),
      _getAutoRunXContentOpenFolder().contains(audioCdda),
      _getAutoRunXContentStartApp().contains(audioCdda),
      !_getAutoRunXContentIgnore().contains(audioCdda) &&
          !_getAutoRunXContentOpenFolder().contains(audioCdda) &&
          !_getAutoRunXContentStartApp().contains(audioCdda)
    ];
  }

  set setAudioStartup(int value) {
    switch (value) {
      case 0:
        _addAudioCddaToIgnoreList();
        _removeAudioCddaFromFolderList();
        _removeAudioCddaFromAppStartList();
        break;
      case 1:
        _addAudioCddaToFolderList();
        _removeAudioCddaFromIgnoreList();
        _removeAudioCddaFromAppStartList();
        break;
      case 2:
        _addAudioCddaToAppStartList();
        _removeAudioCddaFromIgnoreList();
        _removeAudioCddaFromFolderList();
        break;
      case 3:
        _removeAudioCddaFromIgnoreList();
        _removeAudioCddaFromFolderList();
        _removeAudioCddaFromAppStartList();
        break;
      default:
    }
  }

  void _addAudioCddaToAppStartList() {
    final oldStartAppList = _getAutoRunXContentStartApp();
    oldStartAppList.add(audioCdda);
    _setAutoRunXContentStartApp(oldStartAppList.toList());
  }

  void _removeAudioCddaFromIgnoreList() {
    final oldIgnoreList = _getAutoRunXContentIgnore();
    oldIgnoreList.remove(audioCdda);
    _setAutoRunXContentIgnore(oldIgnoreList.toList());
  }

  void _addAudioCddaToFolderList() {
    final oldOpenFolderList = _getAutoRunXContentOpenFolder();
    oldOpenFolderList.add(audioCdda);
    _setAutoRunXContentOpenFolder(oldOpenFolderList.toList());
  }

  void _removeAudioCddaFromAppStartList() {
    final oldStartAppList = _getAutoRunXContentStartApp();
    oldStartAppList.remove(audioCdda);
    _setAutoRunXContentStartApp(oldStartAppList.toList());
  }

  void _removeAudioCddaFromFolderList() {
    final oldOpenFolderList = _getAutoRunXContentOpenFolder();
    oldOpenFolderList.remove(audioCdda);
    _setAutoRunXContentOpenFolder(oldOpenFolderList.toList());
  }

  void _addAudioCddaToIgnoreList() {
    final oldIgnoreList = _getAutoRunXContentIgnore();
    oldIgnoreList.add(audioCdda);
    _setAutoRunXContentIgnore(oldIgnoreList.toList());
  }

  // DVD-Video
  List<bool>? get getDvdStartup {
    return [
      _getAutoRunXContentIgnore().contains(videoDvd),
      _getAutoRunXContentOpenFolder().contains(videoDvd),
      _getAutoRunXContentStartApp().contains(videoDvd),
      !_getAutoRunXContentIgnore().contains(videoDvd) &&
          !_getAutoRunXContentOpenFolder().contains(videoDvd) &&
          !_getAutoRunXContentStartApp().contains(videoDvd)
    ];
  }

  set setDvdStartup(int value) {
    switch (value) {
      case 0:
        _addDvdToIgnoreList();
        _removeDvdFromFolderList();
        _removeDvdFromAppStartList();
        break;
      case 1:
        _addDvdToFolderList();
        _removeDvdFromIgnoreList();
        _removeDvdFromAppStartList();
        break;
      case 2:
        _addDvdToAppStartList();
        _removeDvdFromIgnoreList();
        _removeDvdFromFolderList();
        break;
      case 3:
        _removeDvdFromIgnoreList();
        _removeDvdFromFolderList();
        _removeDvdFromAppStartList();
        break;
      default:
    }
  }

  void _addDvdToAppStartList() {
    final oldStartAppList = _getAutoRunXContentStartApp();
    oldStartAppList.add(videoDvd);
    _setAutoRunXContentStartApp(oldStartAppList.toList());
  }

  void _removeDvdFromIgnoreList() {
    final oldIgnoreList = _getAutoRunXContentIgnore();
    oldIgnoreList.remove(videoDvd);
    _setAutoRunXContentIgnore(oldIgnoreList.toList());
  }

  void _addDvdToFolderList() {
    final oldOpenFolderList = _getAutoRunXContentOpenFolder();
    oldOpenFolderList.add(videoDvd);
    _setAutoRunXContentOpenFolder(oldOpenFolderList.toList());
  }

  void _removeDvdFromAppStartList() {
    final oldStartAppList = _getAutoRunXContentStartApp();
    oldStartAppList.remove(videoDvd);
    _setAutoRunXContentStartApp(oldStartAppList.toList());
  }

  void _removeDvdFromFolderList() {
    final oldOpenFolderList = _getAutoRunXContentOpenFolder();
    oldOpenFolderList.remove(videoDvd);
    _setAutoRunXContentOpenFolder(oldOpenFolderList.toList());
  }

  void _addDvdToIgnoreList() {
    final oldIgnoreList = _getAutoRunXContentIgnore();
    oldIgnoreList.add(videoDvd);
    _setAutoRunXContentIgnore(oldIgnoreList.toList());
  }

  // Musicplayer
  List<bool>? get getMusicPlayerStartup {
    return [
      _getAutoRunXContentIgnore().contains(audioPlayer),
      _getAutoRunXContentOpenFolder().contains(audioPlayer),
      _getAutoRunXContentStartApp().contains(audioPlayer),
      !_getAutoRunXContentIgnore().contains(audioPlayer) &&
          !_getAutoRunXContentOpenFolder().contains(audioPlayer) &&
          !_getAutoRunXContentStartApp().contains(audioPlayer)
    ];
  }

  set setMusicPlayerStartup(int value) {
    switch (value) {
      case 0:
        _addMusicPlayerToIgnoreList();
        _removeMusicPlayerFromFolderList();
        _removeMusicPlayerFromAppStartList();
        break;
      case 1:
        _addMusicPlayerToFolderList();
        _removeMusicPlayerFromIgnoreList();
        _removeMusicPlayerFromAppStartList();
        break;
      case 2:
        _addMusicPlayerToAppStartList();
        _removeMusicPlayerFromIgnoreList();
        _removeMusicPlayerFromFolderList();
        break;
      case 3:
        _removeMusicPlayerFromIgnoreList();
        _removeMusicPlayerFromFolderList();
        _removeMusicPlayerFromAppStartList();
        break;
      default:
    }
  }

  void _addMusicPlayerToAppStartList() {
    final oldStartAppList = _getAutoRunXContentStartApp();
    oldStartAppList.add(audioPlayer);
    _setAutoRunXContentStartApp(oldStartAppList.toList());
  }

  void _removeMusicPlayerFromIgnoreList() {
    final oldIgnoreList = _getAutoRunXContentIgnore();
    oldIgnoreList.remove(audioPlayer);
    _setAutoRunXContentIgnore(oldIgnoreList.toList());
  }

  void _addMusicPlayerToFolderList() {
    final oldOpenFolderList = _getAutoRunXContentOpenFolder();
    oldOpenFolderList.add(audioPlayer);
    _setAutoRunXContentOpenFolder(oldOpenFolderList.toList());
  }

  void _removeMusicPlayerFromAppStartList() {
    final oldStartAppList = _getAutoRunXContentStartApp();
    oldStartAppList.remove(audioPlayer);
    _setAutoRunXContentStartApp(oldStartAppList.toList());
  }

  void _removeMusicPlayerFromFolderList() {
    final oldOpenFolderList = _getAutoRunXContentOpenFolder();
    oldOpenFolderList.remove(audioPlayer);
    _setAutoRunXContentOpenFolder(oldOpenFolderList.toList());
  }

  void _addMusicPlayerToIgnoreList() {
    final oldIgnoreList = _getAutoRunXContentIgnore();
    oldIgnoreList.add(audioPlayer);
    _setAutoRunXContentIgnore(oldIgnoreList.toList());
  }

  // Photos
  List<bool>? get getPhotoViewerStartup {
    return [
      _getAutoRunXContentIgnore().contains(imageDcf),
      _getAutoRunXContentOpenFolder().contains(imageDcf),
      _getAutoRunXContentStartApp().contains(imageDcf),
      !_getAutoRunXContentIgnore().contains(imageDcf) &&
          !_getAutoRunXContentOpenFolder().contains(imageDcf) &&
          !_getAutoRunXContentStartApp().contains(imageDcf)
    ];
  }

  set setPhotoViewerStartup(int value) {
    switch (value) {
      case 0:
        _addPhotoViewerToIgnoreList();
        _removePhotoViewerFromFolderList();
        _removePhotoViewerFromAppStartList();
        break;
      case 1:
        _addPhotoViewerToFolderList();
        _removePhotoViewerFromIgnoreList();
        _removePhotoViewerFromAppStartList();
        break;
      case 2:
        _addPhotoViewerToAppStartList();
        _removePhotoViewerFromIgnoreList();
        _removePhotoViewerFromFolderList();
        break;
      case 3:
        _removePhotoViewerFromIgnoreList();
        _removePhotoViewerFromFolderList();
        _removePhotoViewerFromAppStartList();
        break;
      default:
    }
  }

  void _addPhotoViewerToAppStartList() {
    final oldStartAppList = _getAutoRunXContentStartApp();
    oldStartAppList.add(imageDcf);
    _setAutoRunXContentStartApp(oldStartAppList.toList());
  }

  void _removePhotoViewerFromIgnoreList() {
    final oldIgnoreList = _getAutoRunXContentIgnore();
    oldIgnoreList.remove(imageDcf);
    _setAutoRunXContentIgnore(oldIgnoreList.toList());
  }

  void _addPhotoViewerToFolderList() {
    final oldOpenFolderList = _getAutoRunXContentOpenFolder();
    oldOpenFolderList.add(imageDcf);
    _setAutoRunXContentOpenFolder(oldOpenFolderList.toList());
  }

  void _removePhotoViewerFromAppStartList() {
    final oldStartAppList = _getAutoRunXContentStartApp();
    oldStartAppList.remove(imageDcf);
    _setAutoRunXContentStartApp(oldStartAppList.toList());
  }

  void _removePhotoViewerFromFolderList() {
    final oldOpenFolderList = _getAutoRunXContentOpenFolder();
    oldOpenFolderList.remove(imageDcf);
    _setAutoRunXContentOpenFolder(oldOpenFolderList.toList());
  }

  void _addPhotoViewerToIgnoreList() {
    final oldIgnoreList = _getAutoRunXContentIgnore();
    oldIgnoreList.add(imageDcf);
    _setAutoRunXContentIgnore(oldIgnoreList.toList());
  }

  // Apps
  List<bool>? get getAppsStartup {
    return [
      _getAutoRunXContentIgnore().contains(unixSoftware),
      _getAutoRunXContentOpenFolder().contains(unixSoftware),
      _getAutoRunXContentStartApp().contains(unixSoftware),
      !_getAutoRunXContentIgnore().contains(unixSoftware) &&
          !_getAutoRunXContentOpenFolder().contains(unixSoftware) &&
          !_getAutoRunXContentStartApp().contains(unixSoftware)
    ];
  }

  set setAppsStartup(int value) {
    switch (value) {
      case 0:
        _addAppsToIgnoreList();
        _removeAppsFromFolderList();
        _removeAppsFromAppStartList();
        break;
      case 1:
        _addAppsToFolderList();
        _removeAppsFromIgnoreList();
        _removeAppsFromAppStartList();
        break;
      case 2:
        _addAppsToAppStartList();
        _removeAppsFromIgnoreList();
        _removeAppsFromFolderList();
        break;
      case 3:
        _removeAppsFromIgnoreList();
        _removeAppsFromFolderList();
        _removeAppsFromAppStartList();
        break;
      default:
    }
  }

  void _addAppsToAppStartList() {
    final oldStartAppList = _getAutoRunXContentStartApp();
    oldStartAppList.add(unixSoftware);
    _setAutoRunXContentStartApp(oldStartAppList.toList());
  }

  void _removeAppsFromIgnoreList() {
    final oldIgnoreList = _getAutoRunXContentIgnore();
    oldIgnoreList.remove(unixSoftware);
    _setAutoRunXContentIgnore(oldIgnoreList.toList());
  }

  void _addAppsToFolderList() {
    final oldOpenFolderList = _getAutoRunXContentOpenFolder();
    oldOpenFolderList.add(unixSoftware);
    _setAutoRunXContentOpenFolder(oldOpenFolderList.toList());
  }

  void _removeAppsFromAppStartList() {
    final oldStartAppList = _getAutoRunXContentStartApp();
    oldStartAppList.remove(unixSoftware);
    _setAutoRunXContentStartApp(oldStartAppList.toList());
  }

  void _removeAppsFromFolderList() {
    final oldOpenFolderList = _getAutoRunXContentOpenFolder();
    oldOpenFolderList.remove(unixSoftware);
    _setAutoRunXContentOpenFolder(oldOpenFolderList.toList());
  }

  void _addAppsToIgnoreList() {
    final oldIgnoreList = _getAutoRunXContentIgnore();
    oldIgnoreList.add(unixSoftware);
    _setAutoRunXContentIgnore(oldIgnoreList.toList());
  }

  @override
  void dispose() {
    _removableMediaSettings?.dispose();
    super.dispose();
  }
}
