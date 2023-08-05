import 'package:flutter/foundation.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class NotificationsModel extends ChangeNotifier {
  NotificationsModel(SettingsService service)
      : _notificationSettings = service.lookup(schemaNotifications) {
    _notificationSettings?.addListener(notifyListeners);
  }
  static const _showBannersKey = 'show-banners';
  static const _showInLockScreenKey = 'show-in-lock-screen';

  @override
  void dispose() {
    _notificationSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  final Settings? _notificationSettings;

  // Global section

  bool? get doNotDisturb {
    return _notificationSettings?.boolValue(_showBannersKey) == false;
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
      ?.whereType<String>()
      .toList();
}

class AppNotificationsModel extends ChangeNotifier {
  AppNotificationsModel(this.appId, SettingsService service)
      : _appNotificationSettings =
            service.lookup(_appSchemaId, path: _getPath(appId)) {
    _appNotificationSettings?.addListener(notifyListeners);
  }
  static const _enableKey = 'enable';
  static const _appSchemaId = '$schemaNotifications.application';

  @override
  void dispose() {
    _appNotificationSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  final String appId;
  final Settings? _appNotificationSettings;

  static String _getPath(String appId) {
    return '/${_appSchemaId.replaceAll('.', '/')}/$appId/';
  }

  bool? get enable => _appNotificationSettings?.boolValue(_enableKey);
  void setEnable(bool value) {
    _appNotificationSettings?.setValue(_enableKey, value);
    notifyListeners();
  }
}
