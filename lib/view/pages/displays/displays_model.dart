import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/services/display/display_service.dart';
import 'package:settings/view/pages/displays/displays_configuration.dart';

class DisplaysModel extends SafeChangeNotifier {
  /// Constructor
  DisplaysModel(this._service) {
    /// listen display stream
    /// on each, re-set new configuration
    _subscription = _service.monitorStateStream.listen((configuration) {
      _initialNotifier.value = configuration;
      _currentNotifier.value = configuration;
    });
  }

  ValueNotifier<DisplaysConfiguration?> get _initialNotifier =>
      _service.initialNotifier;
  ValueNotifier<DisplaysConfiguration?> get _currentNotifier =>
      _service.currentNotifier;

  StreamSubscription? _subscription;

  /// SERVICES
  final DisplayService _service;

  /// GETTERS FOR VIEWS
  ValueListenable<DisplaysConfiguration?> get configuration => _currentNotifier;

  bool get modifyMode => _currentNotifier.value != _initialNotifier.value;

  final List<LogicalMonitorOrientation> displayableOrientations = [
    LogicalMonitorOrientation.normal,
    LogicalMonitorOrientation.$270,
    LogicalMonitorOrientation.$90,
    LogicalMonitorOrientation.$180,
  ];

  /// Apply current configuration
  void apply() => _service.applyConfig();

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

/// All setters to update current configurations
extension DisplayModelSetters on DisplaysModel {
  void setResolution(int index, String resolution) {
    final configurations = <DisplayMonitorConfiguration>[
      ..._currentNotifier.value!.configurations,
    ];

    final configurationMonitorUpdate = configurations.removeAt(index);

    var updated = configurationMonitorUpdate.copyWith(resolution: resolution);

    final currentRefreshRate = double.parse(updated.refreshRate);

    /// select new refresh rate : choose the closest from current
    final newRefreshRate = updated.availableRefreshRates
        .map(
      (rate) => MapEntry(rate, (double.parse(rate) - currentRefreshRate).abs()),
    )
        .reduce((map1, map2) {
      if (map1.value < map2.value) {
        return map1;
      }
      return map2;
    }).key;

    updated = updated.copyWith(
      refreshRate: newRefreshRate,
      fullResolution: '$resolution@$newRefreshRate',
    );

    configurations.insert(index, updated);

    _currentNotifier.value =
        DisplaysConfiguration(configurations: configurations);
  }

  void setRefreshRate(int index, String refreshRate) {
    if (!_currentNotifier.value!.configurations[index].availableRefreshRates
        .contains(refreshRate)) {
      return;
    }

    final configurations = <DisplayMonitorConfiguration>[
      ..._currentNotifier.value!.configurations,
    ];
    final configurationMonitorUpdate = configurations.removeAt(index);

    configurations.insert(
      index,
      configurationMonitorUpdate.copyWith(
        fullResolution: '${configurationMonitorUpdate.resolution}@$refreshRate',
        refreshRate: refreshRate,
      ),
    );
    _currentNotifier.value =
        DisplaysConfiguration(configurations: configurations);
  }

  void setOrientation(int index, LogicalMonitorOrientation orientation) {
    final configurations = <DisplayMonitorConfiguration>[
      ..._currentNotifier.value!.configurations,
    ];
    final configurationMonitorUpdate = configurations.removeAt(index);

    configurations.insert(
      index,
      configurationMonitorUpdate.copyWith(
        transform: orientation.index,
      ),
    );
    _currentNotifier.value =
        DisplaysConfiguration(configurations: configurations);
  }

  void setScale(int index, double scale) {
    final configurations = <DisplayMonitorConfiguration>[
      ..._currentNotifier.value!.configurations,
    ];
    final configurationMonitorUpdate = configurations.removeAt(index);

    configurations.insert(
      index,
      configurationMonitorUpdate.copyWith(
        scale: scale,
      ),
    );
    _currentNotifier.value =
        DisplaysConfiguration(configurations: configurations);
  }
}

/*
0: normal
	  1: 90°
	  2: 180°
	  3: 270°
	  4: flipped
	  5: 90° flipped
	  6: 180° flipped
	  7: 270° flipped
 */
enum LogicalMonitorOrientation {
  normal,
  $90,
  $180,
  $270,
  flipped,
  $90flipped,
  $180flipped,
  $270flipped;

  String localize(BuildContext context) {
    switch (this) {
      case LogicalMonitorOrientation.normal:
        return context.l10n.landscape;
      case LogicalMonitorOrientation.$90:
        return context.l10n.portraitLeft;
      case LogicalMonitorOrientation.$270:
        return context.l10n.portraitRight;
      case LogicalMonitorOrientation.$180:
        return context.l10n.flippedLandscape;
      default:
        return name.replaceAll('\$', '');
    }
  }
}
