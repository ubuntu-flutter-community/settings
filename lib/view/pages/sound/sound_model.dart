import 'package:flutter/foundation.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/schemas/schemas.dart';

class SoundModel extends ChangeNotifier {
  static const _allowAbove100Key = 'allow-volume-above-100-percent';
  static const _eventSoundsKey = 'event-sounds';
  static const _inputFeedbackSounds = 'input-feedback-sounds';

  final _soundSettings = GSettingsSchema.lookup(schemaSound) != null
      ? GSettings(schemaId: schemaSound)
      : null;

  bool? get getAllowAbove100 => _soundSettings?.boolValue(_allowAbove100Key);

  void setAllowAbove100(bool value) {
    _soundSettings?.setValue(_allowAbove100Key, value);
    notifyListeners();
  }

  bool? get getEventSounds => _soundSettings?.boolValue(_eventSoundsKey);

  void setEventSounds(bool value) {
    _soundSettings?.setValue(_eventSoundsKey, value);
    notifyListeners();
  }

  bool? get getInputFeedbackSounds =>
      _soundSettings?.boolValue(_inputFeedbackSounds);

  void setInputFeedbackSounds(bool value) {
    _soundSettings?.setValue(_inputFeedbackSounds, value);
    notifyListeners();
  }
}
