import 'package:gsettings/gsettings.dart';

class SettingsService {
  final _settings = <String, GSettings?>{};

  GSettings? lookup(String schemaId, {String? path}) {
    return _settings[schemaId] ??= GSettingsSchema.lookup(schemaId) != null
        ? GSettings(schemaId: schemaId, path: path)
        : null;
  }

  void dispose() {
    for (final settings in _settings.values) {
      settings?.dispose();
    }
  }
}
