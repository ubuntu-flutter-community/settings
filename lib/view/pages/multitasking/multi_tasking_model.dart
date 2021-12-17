import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class MultiTaskingModel extends SafeChangeNotifier {
  final Settings? _multiTaskingSettings;
  final Settings? _mutterSettings;
  final Settings? _appSwitchSettings;
  final Settings? _wmSettings;

  static const _hotCornersKey = 'enable-hot-corners';
  static const _edgeTilingKey = 'edge-tiling';
  static const _workspacesOnlyOnPrimaryKey = 'workspaces-only-on-primary';
  static const _dynamicWorkspacesKey = 'dynamic-workspaces';
  static const _numWorkspacesKey = 'num-workspaces';
  static const _currentWorkspaceOnlyKey = 'current-workspace-only';

  MultiTaskingModel(SettingsService service)
      : _multiTaskingSettings = service.lookup(schemaInterface),
        _mutterSettings = service.lookup(schemaMutter),
        _appSwitchSettings = service.lookup(schemaGnomeShellAppSwitcher),
        _wmSettings = service.lookup(schemaWmPreferences) {
    _multiTaskingSettings?.addListener(notifyListeners);
    _mutterSettings?.addListener(notifyListeners);
    _appSwitchSettings?.addListener(notifyListeners);
    _wmSettings?.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _multiTaskingSettings?.removeListener(notifyListeners);
    _mutterSettings?.removeListener(notifyListeners);
    _appSwitchSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  bool get enableHotCorners =>
      _multiTaskingSettings!.boolValue(_hotCornersKey) ?? false;

  set enableHotCorners(bool enableHotCorners) {
    _multiTaskingSettings!.setValue(_hotCornersKey, enableHotCorners);
    notifyListeners();
  }

  bool get edgeTiling => _mutterSettings!.getValue(_edgeTilingKey) ?? false;

  set edgeTiling(bool edgeTiling) {
    _mutterSettings!.setValue(_edgeTilingKey, edgeTiling);
    notifyListeners();
  }

  bool get workSpaceOnlyOnPrimary =>
      _mutterSettings!.getValue(_workspacesOnlyOnPrimaryKey) ?? false;

  set workSpaceOnlyOnPrimary(bool value) {
    _mutterSettings!.setValue(_workspacesOnlyOnPrimaryKey, value);
    notifyListeners();
  }

  bool get dynamicWorkspaces =>
      _mutterSettings!.getValue(_dynamicWorkspacesKey) ?? false;

  set dynamicWorkspaces(bool value) {
    _mutterSettings!.setValue(_dynamicWorkspacesKey, value);
    notifyListeners();
  }

  int get numWorkspaces => _wmSettings!.getValue(_numWorkspacesKey);

  set numWorkspaces(int value) {
    _wmSettings!.setValue(_numWorkspacesKey, value);
    notifyListeners();
  }

  bool get currentWorkspaceOnly =>
      _appSwitchSettings!.getValue(_currentWorkspaceOnlyKey) ?? false;

  set currentWorkspaceOnly(bool value) {
    _appSwitchSettings!.setValue(_currentWorkspaceOnlyKey, value);
    notifyListeners();
  }
}
