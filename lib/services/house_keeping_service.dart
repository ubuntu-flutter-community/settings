import 'dart:async';
import 'dart:io';

import 'package:dbus/dbus.dart';

const _kHouseKeepingInterface = 'org.gnome.SettingsDaemon.Housekeeping';
const _kHouseKeepingPath = '/org/gnome/SettingsDaemon/Housekeeping';
const _kEmptyTrashMethodName = 'EmptyTrash';
const _kRemoveTempFiles = 'RemoveTempFiles';
const _kRecentlyUsedFilePathSuffix = '/.local/share/recently-used.xbel';

class HouseKeepingService {
  final DBusRemoteObject _object;

  HouseKeepingService() : _object = _createObject();

  static DBusRemoteObject _createObject() {
    return DBusRemoteObject(
      DBusClient.session(),
      name: _kHouseKeepingInterface,
      path: DBusObjectPath(_kHouseKeepingPath),
    );
  }

  Future<void> dispose() async {
    await _object.client.close();
  }

  void emptyTrash() => _object.emptyTrash();

  void removeTempFiles() => _object.removeTempFiles();

  void clearRecentlyUsed() {
    final String? path =
        Platform.environment['HOME']! + _kRecentlyUsedFilePathSuffix;
    if (Platform.environment['HOME'] == null || path == null) return;
    var file = File(path);
    var sink = file.openWrite();
    const cleanContent = '''<?xml version="1.0" encoding="UTF-8"?>
                            <xbel version="1.0" xmlns:bookmark="http://www.freedesktop.org/standards/desktop-bookmarks" xmlns:mime="http://www.freedesktop.org/standards/shared-mime-info">
                            </xbel>''';
    sink.write(cleanContent);
    sink.close();
  }
}

extension _HouseKeepingObject on DBusRemoteObject {
  Future<DBusMethodSuccessResponse> emptyTrash() {
    return callMethod(_kHouseKeepingInterface, _kEmptyTrashMethodName, []);
  }

  Future<DBusMethodSuccessResponse> removeTempFiles() {
    return callMethod(_kHouseKeepingInterface, _kRemoveTempFiles, []);
  }
}
