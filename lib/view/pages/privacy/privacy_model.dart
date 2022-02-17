import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

// trash: org.gnome.desktop.privacy remove-old-trash-files false
// temp files: org.gnome.desktop.privacy remove-old-temp-files true

const _removeOldTrashFilesKey = 'remove-old-trash-files';
const _removeOldTempFilesKey = 'remove-old-temp-files';
const _rememberRecentFilesKey = 'remember-recent-files';
const _recentFilesMaxAgeKey = 'recent-files-max-age';
const _oldFilesAgeKey = 'old-files-age';

class PrivacyModel extends SafeChangeNotifier {
  final Settings? _privacySettings;

  PrivacyModel(SettingsService service)
      : _privacySettings = service.lookup(schemaPrivacy) {
    _privacySettings?.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _privacySettings?.removeListener(notifyListeners);
    super.dispose();
  }

  bool? get removeOldTrashFiles =>
      _privacySettings?.getValue(_removeOldTrashFilesKey);

  set removeOldTrashFiles(bool? value) {
    if (value == null) return;
    _privacySettings?.setValue(_removeOldTrashFilesKey, value);
    notifyListeners();
  }

  bool? get removeOldTempFiles =>
      _privacySettings?.getValue(_removeOldTempFilesKey);

  set removeOldTempFiles(bool? value) {
    if (value == null) return;
    _privacySettings?.setValue(_removeOldTempFilesKey, value);
    notifyListeners();
  }

  bool? get rememberRecentFiles =>
      _privacySettings?.getValue(_rememberRecentFilesKey);

  set rememberRecentFiles(bool? value) {
    if (value == null) return;
    _privacySettings?.setValue(_rememberRecentFilesKey, value);
    notifyListeners();
  }

  int? get recentFilesMaxAge =>
      _privacySettings?.getValue(_recentFilesMaxAgeKey);
  set recentFilesMaxAge(int? value) {
    if (value == null) return;
    _privacySettings?.setValue(_recentFilesMaxAgeKey, value);
    notifyListeners();
  }

  int? get oldFilesAge => _privacySettings?.getValue(_oldFilesAgeKey);
  set oldFilesAge(int? value) {
    if (value == null) return;
    _privacySettings?.setValue(_oldFilesAgeKey, value);
    notifyListeners();
  }
}
