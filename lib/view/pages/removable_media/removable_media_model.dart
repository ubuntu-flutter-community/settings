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

  // autorun-x-content-ignore
  final _autoRunXContentIgnoreKey = 'autorun-x-content-ignore';
  List<String?> get autoRunXContentIgnore =>
      _removableMediaSettings!.stringArrayValue(_autoRunXContentIgnoreKey);
  set autoRunXContentIgnore(List<String?> value) {
    _removableMediaSettings!.setValue(_autoRunXContentIgnoreKey, value);
    notifyListeners();
  }

  // autorun-x-content-open-folder
  final _autoRunXContentOpenFolderKey = 'autorun-x-content-open-folder';
  List<String?> get autoRunXContentOpenFolder =>
      _removableMediaSettings!.stringArrayValue(_autoRunXContentOpenFolderKey);
  set autoRunXContentOpenFolder(List<String?> value) {
    _removableMediaSettings!.setValue(_autoRunXContentOpenFolderKey, value);
    notifyListeners();
  }

  // autorun-x-content-start-app
  final _autoRunXContentStartAppKey = 'autorun-x-content-start-app';
  List<String?> get autoRunXContentStartApp =>
      _removableMediaSettings!.stringArrayValue(_autoRunXContentStartAppKey);
  set autoRunXContentStartApp(List<String?> value) {
    _removableMediaSettings!.setValue(_autoRunXContentStartAppKey, value);
    notifyListeners();
  }

  // autorun-never
  final _autoRunNeverKey = 'autorun-never';
  bool get autoRunNever => _removableMediaSettings!.boolValue(_autoRunNeverKey);
  set autoRunNever(bool value) {
    _removableMediaSettings!.setValue(_autoRunNeverKey, value);
    notifyListeners();
  }

  @override
  void dispose() {
    _removableMediaSettings?.dispose();
    super.dispose();
  }
}
