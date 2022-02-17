import 'dart:async';

import 'package:dbus/dbus.dart';

const kHouseKeepingInterface = 'org.gnome.SettingsDaemon.Housekeeping';
const kHouseKeepingPath = '/org/gnome/SettingsDaemon/Housekeeping';
const kEmptyTrashMethodName = 'EmptyTrash';
const kRemoveTempFiles = 'RemoveTempFiles';

class HouseKeepingService {
  final DBusRemoteObject _object;

  HouseKeepingService() : _object = _createObject();

  static DBusRemoteObject _createObject() {
    return DBusRemoteObject(
      DBusClient.session(),
      name: kHouseKeepingInterface,
      path: DBusObjectPath(kHouseKeepingPath),
    );
  }

  Future<void> dispose() async {
    await _object.client.close();
  }

  void emptyTrash() => _object.emptyTrash();

  void removeTempFiles() => _object.removeTempFiles();
}

extension _HouseKeepingObject on DBusRemoteObject {
  Future<DBusMethodSuccessResponse> emptyTrash() {
    return callMethod(kHouseKeepingInterface, kEmptyTrashMethodName, []);
  }

  Future<DBusMethodSuccessResponse> removeTempFiles() {
    return callMethod(kHouseKeepingInterface, kRemoveTempFiles, []);
  }
}
