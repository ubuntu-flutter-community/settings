import 'package:flutter/foundation.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';

class SoundModel extends ChangeNotifier {
  SoundModel(SettingsService service)
      : _soundSettings = service.lookup(schemaSound) {
    _soundSettings?.addListener(notifyListeners);
  }
  static const _allowAbove100Key = 'allow-volume-above-100-percent';
  static const _eventSoundsKey = 'event-sounds';
  static const _inputFeedbackSounds = 'input-feedback-sounds';

  @override
  void dispose() {
    _soundSettings?.removeListener(notifyListeners);
    super.dispose();
  }

  final Settings? _soundSettings;

  // System section

  bool? get allowAbove100 => _soundSettings?.boolValue(_allowAbove100Key);

  void setAllowAbove100(bool value) {
    _soundSettings?.setValue(_allowAbove100Key, value);
    notifyListeners();
  }

  bool? get eventSounds => _soundSettings?.boolValue(_eventSoundsKey);

  void setEventSounds(bool value) {
    _soundSettings?.setValue(_eventSoundsKey, value);
    notifyListeners();
  }

  bool? get inputFeedbackSounds =>
      _soundSettings?.boolValue(_inputFeedbackSounds);

  void setInputFeedbackSounds(bool value) {
    _soundSettings?.setValue(_inputFeedbackSounds, value);
    notifyListeners();
  }
}
