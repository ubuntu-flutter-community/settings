import 'package:dbus/dbus.dart';

const _kAccountsInterface = 'org.freedesktop.Accounts';
const _kAccountsPath = '/org/freedesktop/Accounts';
// Methods
const _kCacheUser = 'CacheUser'; // CacheUser (String name) ↦ (Object Path user)
const _kCreateUser = 'CreateUser';
// CreateUser (String name, String fullname, Int32 accountType) ↦ (Object Path user)
const _kDeleteUser = 'DeleteUser';
// DeleteUser (Int64 id, Boolean removeFiles) ↦ ()
const _kFindUserById = 'FindUserById';
// FindUserById (Int64 id) ↦ (Object Path user)
const _kfindUserByName = 'FindUserByName';
// FindUserByName (String name) ↦ (Object Path user)
const _kListCachedUsers = 'ListCachedUsers';
// ListCachedUsers () ↦ (Array of [Object Path] users)
const _kUncacheUser = 'UncacheUser';
// UncacheUser (String name) ↦ ()
// Properties
const _kAutomaticLoginUsers =
    'AutomaticLoginUsers'; // AutomaticLoginUsers, read, Array of [Object Path]
const _kHasMultipleUsers = 'HasMultipleUsers'; // read, boolean
const _kDaemonVersion = 'DaemonVersion'; // String
// Signals
const _kUserAdded = 'UserAdded';
const _kUserDeleted = 'UserDeleted';

class AccountsService {
  final DBusRemoteObject _object;

  AccountsService() : _object = _createObject();

  static DBusRemoteObject _createObject() => DBusRemoteObject(
        DBusClient.system(),
        name: _kAccountsInterface,
        path: DBusObjectPath(_kAccountsPath),
      );
}

extension _AccountsRemoteObject on DBusRemoteObject {
  Future<DBusObjectPath> cacheUser(String name) async {
    final args = [DBusString(name)];
    final res = await callMethod(_kAccountsInterface, _kCacheUser, args);
    return res as DBusObjectPath;
  }
}

extension _AccountsSignal on DBusPropertiesChangedSignal {
  bool get userAdded => changedProperties.containsKey(_kUserAdded);

  bool get userDeleted => changedProperties.containsKey(_kUserDeleted);
}
