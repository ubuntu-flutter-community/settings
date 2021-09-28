import 'package:flutter/foundation.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/schemas/schemas.dart';

class NotificationsModel extends ChangeNotifier {
  static const _showBannersKey = 'show-banners';
  static const _showInLockScreenKey = 'show-in-lock-screen';

  final _notificationSettings =
      GSettingsSchema.lookup(schemaNotifications) != null
          ? GSettings(schemaId: schemaNotifications)
          : null;

  @override
  void dispose() {
    _notificationSettings?.dispose();
    super.dispose();
  }

  // Global section

  bool? get doNotDisturb {
    if (_notificationSettings != null) {
      return !_notificationSettings!.boolValue(_showBannersKey);
    }
  }

  void setDoNotDisturb(bool value) {
    _notificationSettings?.setValue(_showBannersKey, !value);
    notifyListeners();
  }

  bool? get showOnLockScreen =>
      _notificationSettings?.boolValue(_showInLockScreenKey);

  void setShowOnLockScreen(bool value) {
    _notificationSettings?.setValue(_showInLockScreenKey, value);
    notifyListeners();
  }

  // App section

  List<String>? get applications => _notificationSettings
      ?.stringArrayValue('application-children')
      .whereType<String>()
      .toList();
}

class AppNotificationsModel extends ChangeNotifier {
  static const _enableKey = 'enable';
  static const _appSchemaId = schemaNotifications + '.application';

  AppNotificationsModel(this.appId)
      : _appNotificationSettings = GSettingsSchema.lookup(_appSchemaId) != null
            ? GSettings(schemaId: _appSchemaId, path: _getPath(appId))
            : null;

  final String appId;
  final GSettings? _appNotificationSettings;

  @override
  void dispose() {
    _appNotificationSettings?.dispose();
    super.dispose();
  }

  static String _getPath(String appId) {
    return '/' +
        _appSchemaId.replaceAll('.', '/') +
        '/' +
        appId.toString() +
        '/';
  }

  bool? get enable => _appNotificationSettings?.boolValue(_enableKey);
  void setEnable(bool value) {
    _appNotificationSettings?.setValue(_enableKey, value);
    notifyListeners();
  }
}
