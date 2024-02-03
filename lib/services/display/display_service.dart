import 'dart:async';

import 'package:dbus/dbus.dart';
import 'package:flutter/foundation.dart';
import 'package:settings/services/display/display_dbus_service.dart';
import 'package:settings/services/display/objects/dbus_displays_config.dart';
import 'package:settings/view/pages/displays/displays_configuration.dart';

class DisplayService {
  DisplayService()
      : _displayDBusService = DisplayDBusService(),
        _currentNotifier = ValueNotifier(null),
        _initialNotifier = ValueNotifier(null) {
    _loadState(notifyStream: true).then((value) {
      _initialNotifier.value = value;
      _currentNotifier.value = value;
    });

    _displayDBusService.streamChanges
        .map(_mapToModel)
        .listen(_monitorStateStreamController.add);
  }

  final DisplayDBusService _displayDBusService;

  final StreamController<DisplaysConfiguration> _monitorStateStreamController =
      StreamController<DisplaysConfiguration>.broadcast();

  Stream<DisplaysConfiguration> get monitorStateStream =>
      _monitorStateStreamController.stream;

  DisplaysConfiguration? latest;

  /// NOTIFIERS
  final ValueNotifier<DisplaysConfiguration?> _initialNotifier;

  ValueNotifier<DisplaysConfiguration?> get initialNotifier => _initialNotifier;

  final ValueNotifier<DisplaysConfiguration?> _currentNotifier;

  ValueNotifier<DisplaysConfiguration?> get currentNotifier => _currentNotifier;

  Future<void> dispose() async {
    _initialNotifier.dispose();
    _currentNotifier.dispose();
    await Future.wait([
      _displayDBusService.dispose(),
      _monitorStateStreamController.close(),
    ]);
  }

  Future<void> applyConfig() async {
    /// do nothing if no way to perform applyConfig (made to be safe, but we may
    /// never pass here)
    if (_currentNotifier.value == null) {}

    final displayConfig = await _displayDBusService.getCurrent();

    final logicalParameterValues = <DBusStruct>[];

    for (var i = 0; i < displayConfig.monitorsLength; i++) {
      final confMonitor = _currentNotifier.value!.configurations[i];

      // x ; y ; scale ; transform(rotation) ; primary ; monitors
      logicalParameterValues.add(
        DBusStruct([
          DBusInt32(
            displayConfig.currentLogicalConfiguration(i).offsetX,
          ), //offset x
          DBusInt32(
            displayConfig.currentLogicalConfiguration(i).offsetY,
          ), // offset y
          DBusDouble(
            confMonitor.scale ??
                displayConfig.currentLogicalConfiguration(i).scale,
          ), // scale
          DBusUint32(
            confMonitor.transform?.index ??
                displayConfig.currentLogicalConfiguration(i).orientation,
          ), //transform
          DBusBoolean(
            confMonitor.primary ??
                displayConfig.currentLogicalConfiguration(i).primary,
          ), // primary
          // monitors
          DBusArray(DBusSignature('(ssa{sv})'), [
            DBusStruct([
              DBusString(
                displayConfig.identity(i).connector,
              ), // maybe monitorId ?
              DBusString(confMonitor.monitorModeId), // option selected
              DBusDict.stringVariant({}),
            ]),
          ]),
        ]),
      );
    }

    await _displayDBusService.apply(
      displayConfig.serial,
      ConfigurationMethod.persistent,
      logicalParameterValues,
    );
  }

  Future<DisplaysConfiguration> _loadState({required bool notifyStream}) {
    final future = _displayDBusService
        .getCurrent()
        .then(_mapToModel)
        .then((value) => latest = value);

    if (notifyStream) {
      future.then(_monitorStateStreamController.add);
    }
    return future;
  }

  DisplaysConfiguration _mapToModel(DBusDisplaysConfig dbusConfiguration) {
    final monitorsCount = dbusConfiguration.monitorsLength;
    final confs = <DisplayMonitorConfiguration>[];

    for (var i = 0; i < monitorsCount; i++) {
      /// map data only if there's a current option
      /// if no current option
      ///   => monitor not used
      ///   => monitor ignored and not displayed
      if (dbusConfiguration.currentOption(i) != null) {
        confs.add(
          DisplayMonitorConfiguration.newConstructor(dbusConfiguration, i),
        );
      }
    }

    return DisplaysConfiguration(configurations: confs);
  }
}
