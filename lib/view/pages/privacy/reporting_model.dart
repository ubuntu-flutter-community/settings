import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:yaru/yaru.dart';

const _reportTechnicalProblemsKey = 'report-technical-problems';
const _sendSoftwareUsageStatsKey = 'send-software-usage-stats';

class ReportingModel extends SafeChangeNotifier {
  ReportingModel(GSettingsService service)
      : _privacySettings = service.lookup(schemaPrivacy) {
    _privacySettings?.addListener(notifyListeners);
  }
  final GnomeSettings? _privacySettings;

  @override
  void dispose() {
    _privacySettings?.removeListener(notifyListeners);
    super.dispose();
  }

  bool? get reportTechnicalProblems =>
      _privacySettings?.getValue(_reportTechnicalProblemsKey);
  set reportTechnicalProblems(bool? value) {
    if (value == null) return;
    _privacySettings?.setValue(_reportTechnicalProblemsKey, value);
    notifyListeners();
  }

  bool? get sendSoftwareUsageStats =>
      _privacySettings?.getValue(_sendSoftwareUsageStatsKey);
  set sendSoftwareUsageStats(bool? value) {
    if (value == null) return;
    _privacySettings?.setValue(_sendSoftwareUsageStatsKey, value);
    notifyListeners();
  }
}
