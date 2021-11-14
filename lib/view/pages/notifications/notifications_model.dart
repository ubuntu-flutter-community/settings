import 'package:flutter/foundation.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class NotificationsModel extends ChangeNotifier {
  static const _showBannersKey = 'show-banners';
  static const _showInLockScreenKey = 'show-in-lock-screen';

  NotificationsModel(SettingsService service)
      : _notificationSettings = service.lookup(schemaNotifications);

  final GSettings? _notificationSettings;

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

  AppNotificationsModel(this.appId, SettingsService service)
      : _appNotificationSettings =
            service.lookup(_appSchemaId, path: _getPath(appId));

  final String appId;
  final GSettings? _appNotificationSettings;

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
