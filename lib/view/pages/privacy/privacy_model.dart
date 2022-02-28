import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/house_keeping_service.dart';
import 'package:settings/services/settings_service.dart';

const _removeOldTrashFilesKey = 'remove-old-trash-files';
const _removeOldTempFilesKey = 'remove-old-temp-files';
const _rememberRecentFilesKey = 'remember-recent-files';
const _recentFilesMaxAgeKey = 'recent-files-max-age';
const _oldFilesAgeKey = 'old-files-age';

class PrivacyModel extends SafeChangeNotifier {
  final Settings? _privacySettings;
  final HouseKeepingService _houseKeepingService;

  PrivacyModel(
      SettingsService settingsService, HouseKeepingService houseKeepingService)
      : _privacySettings = settingsService.lookup(schemaPrivacy),
        _houseKeepingService = houseKeepingService {
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

  void emptyTrash() => _houseKeepingService.emptyTrash();

  void removeTempFiles() => _houseKeepingService.removeTempFiles();

  void clearRecentlyUsed() => _houseKeepingService.clearRecentlyUsed();
}
