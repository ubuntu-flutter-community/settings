import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class MultiTaskingModel extends SafeChangeNotifier {
  final Settings? _multiTaskingSettings;
  final Settings? _mutterSettings;
  final Settings? _appSwitchSettings;
  final Settings? _wmSettings;
  final Settings? _dashToDockSettings;

  static const _hotCornersKey = 'enable-hot-corners';
  static const _edgeTilingKey = 'edge-tiling';
  static const _workspacesOnlyOnPrimaryKey = 'workspaces-only-on-primary';
  static const _dynamicWorkspacesKey = 'dynamic-workspaces';
  static const _numWorkspacesKey = 'num-workspaces';
  static const _currentWorkspaceOnlyKey = 'current-workspace-only';
  static const _dockPositionKey = 'dock-position';
  static const _extendHeightKey = 'extend-height';

  MultiTaskingModel(SettingsService service)
      : _multiTaskingSettings = service.lookup(schemaInterface),
        _mutterSettings = service.lookup(schemaMutter),
        _appSwitchSettings = service.lookup(schemaGnomeShellAppSwitcher),
        _wmSettings = service.lookup(schemaWmPreferences),
        _dashToDockSettings = service.lookup(schemaDashToDock) {
    _multiTaskingSettings?.addListener(notifyListeners);
    _mutterSettings?.addListener(notifyListeners);
    _appSwitchSettings?.addListener(notifyListeners);
    _wmSettings?.addListener(notifyListeners);
    _dashToDockSettings?.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _multiTaskingSettings?.removeListener(notifyListeners);
    _mutterSettings?.removeListener(notifyListeners);
    _appSwitchSettings?.removeListener(notifyListeners);
    _dashToDockSettings?.removeListener(notifyListeners);
    _wmSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  bool? get enableHotCorners =>
      _multiTaskingSettings?.boolValue(_hotCornersKey);

  set enableHotCorners(bool? enableHotCorners) {
    if (enableHotCorners != null) {
      _multiTaskingSettings?.setValue(_hotCornersKey, enableHotCorners);
      notifyListeners();
    }
  }

  bool? get edgeTiling => _mutterSettings!.getValue(_edgeTilingKey) ?? false;

  set edgeTiling(bool? edgeTiling) {
    if (edgeTiling != null) {
      _mutterSettings?.setValue(_edgeTilingKey, edgeTiling);
      notifyListeners();
    }
  }

  bool? get workSpaceOnlyOnPrimary =>
      _mutterSettings?.getValue(_workspacesOnlyOnPrimaryKey);

  set workSpaceOnlyOnPrimary(bool? value) {
    if (value != null) {
      _mutterSettings?.setValue(_workspacesOnlyOnPrimaryKey, value);
      notifyListeners();
    }
  }

  bool? get dynamicWorkspaces =>
      _mutterSettings?.getValue(_dynamicWorkspacesKey);

  set dynamicWorkspaces(bool? value) {
    if (value != null) {
      _mutterSettings?.setValue(_dynamicWorkspacesKey, value);
      notifyListeners();
    }
  }

  int? get numWorkspaces => _wmSettings!.getValue(_numWorkspacesKey);

  set numWorkspaces(int? value) {
    if (value != null && value > 0) {
      _wmSettings?.setValue(_numWorkspacesKey, value);
      notifyListeners();
    }
  }

  bool? get currentWorkspaceOnly =>
      _appSwitchSettings?.getValue(_currentWorkspaceOnlyKey);

  set currentWorkspaceOnly(bool? value) {
    if (value != null) {
      _appSwitchSettings?.setValue(_currentWorkspaceOnlyKey, value);
      notifyListeners();
    }
  }

  String _getDockPosition() {
    return _dashToDockSettings?.getValue(_dockPositionKey) ?? 'LEFT';
  }

  bool _getExtendHeight() {
    return _dashToDockSettings?.getValue(_extendHeightKey) ?? true;
  }

  String getHotCornerAsset() {
    // DOCK
    if (_getExtendHeight() == false) {
      if (_getDockPosition() == 'RIGHT') {
        return 'assets/images/multitasking/hot-corner-dock-mode/hot-corner-dock-right.svg';
      }
      if (_getDockPosition() == 'BOTTOM') {
        return 'assets/images/multitasking/hot-corner-dock-mode/hot-corner-dock-bottom.svg';
      }
      if (_getDockPosition() == 'LEFT') {
        return 'assets/images/multitasking/hot-corner-dock-mode/hot-corner-dock-left.svg';
      }
    }
    // PANEL
    if (_getDockPosition() == 'RIGHT') {
      return 'assets/images/multitasking/hot-corner-panel-mode/hot-corner-panel-right.svg';
    }
    if (_getDockPosition() == 'BOTTOM') {
      return 'assets/images/multitasking/hot-corner-panel-mode/hot-corner-panel-bottom.svg';
    }
    return 'assets/images/multitasking/hot-corner-panel-mode/hot-corner-panel-left.svg';
  }

  String getActiveEdgesAsset() {
    // DOCK
    if (_getExtendHeight() == false) {
      if (_getDockPosition() == 'RIGHT') {
        return 'assets/images/multitasking/active-screen-edges-dock-mode/active-screen-edges-dock-right.svg';
      }
      if (_getDockPosition() == 'BOTTOM') {
        return 'assets/images/multitasking/active-screen-edges-dock-mode/active-screen-edges-dock-bottom.svg';
      }
      if (_getDockPosition() == 'LEFT') {
        return 'assets/images/multitasking/active-screen-edges-dock-mode/active-screen-edges-dock-left.svg';
      }
    }
    // PANEL
    if (_getDockPosition() == 'RIGHT') {
      return 'assets/images/multitasking/active-screen-edges-panel-mode/active-screen-edges-panel-right.svg';
    }
    if (_getDockPosition() == 'BOTTOM') {
      return 'assets/images/multitasking/active-screen-edges-panel-mode/active-screen-edges-panel-bottom.svg';
    }
    return 'assets/images/multitasking/active-screen-edges-panel-mode/active-screen-edges-panel-left.svg';
  }

  String getWorkspacesSpanDisplayAsset() {
    // DOCK
    if (_getExtendHeight() == false) {
      if (_getDockPosition() == 'RIGHT') {
        return 'assets/images/multitasking/workspaces-dock-mode/workspaces-span-displays-dock-right.svg';
      }
      if (_getDockPosition() == 'BOTTOM') {
        return 'assets/images/multitasking/workspaces-dock-mode/workspaces-span-displays-dock-bottom.svg';
      }
      if (_getDockPosition() == 'LEFT') {
        return 'assets/images/multitasking/workspaces-dock-mode/workspaces-span-displays-dock-left.svg';
      }
    }
    // PANEL
    if (_getDockPosition() == 'RIGHT') {
      return 'assets/images/multitasking/workspaces-panel-mode/workspaces-span-displays-panel-right.svg';
    }
    if (_getDockPosition() == 'BOTTOM') {
      return 'assets/images/multitasking/workspaces-panel-mode/workspaces-span-displays-panel-bottom.svg';
    }
    return 'assets/images/multitasking/workspaces-panel-mode/workspaces-span-displays-panel-left.svg';
  }

  String getWorkspacesPrimaryDisplayAsset() {
    // DOCK
    if (_getExtendHeight() == false) {
      if (_getDockPosition() == 'RIGHT') {
        return 'assets/images/multitasking/workspaces-dock-mode/workspaces-primary-display-dock-right.svg';
      }
      if (_getDockPosition() == 'BOTTOM') {
        return 'assets/images/multitasking/workspaces-dock-mode/workspaces-primary-display-dock-bottom.svg';
      }
      if (_getDockPosition() == 'LEFT') {
        return 'assets/images/multitasking/workspaces-dock-mode/workspaces-primary-display-dock-left.svg';
      }
    }
    // PANEL
    if (_getDockPosition() == 'RIGHT') {
      return 'assets/images/multitasking/workspaces-panel-mode/workspaces-primary-display-panel-right.svg';
    }
    if (_getDockPosition() == 'BOTTOM') {
      return 'assets/images/multitasking/workspaces-panel-mode/workspaces-primary-display-panel-bottom.svg';
    }
    return 'assets/images/multitasking/workspaces-panel-mode/workspaces-primary-display-panel-left.svg';
  }
}
