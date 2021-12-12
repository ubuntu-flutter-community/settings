import 'package:gsettings/gsettings.dart';

class SettingsService {
  final _settings = <String, Settings?>{};

  Settings? lookup(String schemaId, {String? path}) {
    return _settings[schemaId] ??= GSettingsSchema.lookup(schemaId) != null
        ? Settings(schemaId, path: path)
        : null;
  }

  void dispose() {
    for (final settings in _settings.values) {
      settings?.dispose();
    }
  }
}

class Settings {
  Settings(String schemaId, {String? path})
      : _settings = GSettings(schemaId: schemaId, path: path);

  final GSettings _settings;

  void dispose() => _settings.dispose();

  bool? boolValue(String key) => getValue<bool>(key);
  int? intValue(String key) => getValue<int>(key);
  double? doubleValue(String key) => getValue<double>(key);
  String? stringValue(String key) => getValue<String>(key);
  Iterable<String>? stringArrayValue(String key) =>
      getValue<Iterable>(key)?.cast<String>();

  T? getValue<T>(String key) => _settings.value(key) as T?;
  void setValue<T>(String key, Object value) => _settings.setValue(key, value);
  void resetValue(String key) => _settings.resetValue(key);

  void sync() => _settings.sync();
}
