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

  bool? get getDoNotDisturb {
    if (_notificationSettings != null) {
      return !_notificationSettings!.boolValue(_showBannersKey);
    }
  }

  void setDoNotDisturb(bool value) {
    _notificationSettings?.setValue(_showBannersKey, !value);
    notifyListeners();
  }

  bool? get getShowOnLockScreen =>
      _notificationSettings?.boolValue(_showInLockScreenKey);

  void setShowOnLockScreen(bool value) {
    _notificationSettings?.setValue(_showInLockScreenKey, value);
    notifyListeners();
  }
}
