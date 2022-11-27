import 'package:equatable/equatable.dart';
import 'package:settings/services/display/objects/dbus_displays_config.dart';
import 'package:settings/view/pages/displays/displays_model.dart';

class DisplaysConfiguration extends Equatable {
  DisplaysConfiguration({
    required List<DisplayMonitorConfiguration> configurations,
  }) : configurations = List.unmodifiable(configurations);

  final List<DisplayMonitorConfiguration> configurations;

  @override
  List<Object?> get props => <Object?>[
        configurations,
      ];
}

class DisplayMonitorConfiguration extends Equatable {
  DisplayMonitorConfiguration._(
    this._config,
    this._index, {
    required String fullResolution,
    required String resolution,
    required double scale,
    required int transform,
    required bool primary,
    required String refreshRate,
    required String name,
  })  : _fullResolution = fullResolution,
        _resolution = resolution,
        _scale = scale,
        _transform = transform,
        _primary = primary,
        _refreshRate = refreshRate,
        _name = name,
        availableRefreshRates = _config
            .availableOptions(_index)
            .where((option) => option.modeId.split('@')[0] == resolution)
            .map((e) => e.modeId.split('@')[1])
            .toSet()
            .toList(),
        availableResolutions = _config
            .availableOptions(_index)
            .map((option) => option.modeId.split('@')[0])
            .toSet()
            .toList(),
        availableScales = _config.currentOption(_index)?.availableScales ?? [];

  DisplayMonitorConfiguration.newConstructor(this._config, this._index)
      : _fullResolution = _config.currentOption(_index)!.modeId,
        _resolution = _config.currentOption(_index)!.modeId.split('@')[0],
        _scale = _config.currentLogicalConfiguration(_index).scale,
        _transform = _config.currentLogicalConfiguration(_index).orientation,
        _primary = _config.currentLogicalConfiguration(_index).primary,
        _refreshRate = _config.currentOption(_index)!.modeId.split('@')[1],
        _name = _config.displayName(_index),
        availableRefreshRates = _config
            .availableOptions(_index)
            .where(
              (element) =>
                  element.modeId.split('@')[0] ==
                  _config.currentOption(_index)!.modeId.split('@')[0],
            )
            .map((e) => e.modeId.split('@')[1])
            .toSet()
            .toList(),
        availableResolutions = _config
            .availableOptions(_index)
            .map((e) => e.modeId.split('@')[0])
            .toSet()
            .toList(),
        availableScales = _config.currentOption(_index)!.availableScales;

  final int _index;
  final DBusDisplaysConfig _config;
  final String _name;
  final String _fullResolution;
  final String _resolution;
  final String _refreshRate;
  final double _scale;
  final int _transform;
  final bool _primary;

  String get name => _name;

  String get monitorModeId => _fullResolution;

  double? get scale => _scale;

  LogicalMonitorOrientation? get transform =>
      LogicalMonitorOrientation.values[_transform];

  bool? get primary => _primary;

  String get resolution => _resolution;

  double get aspectRatio {
    final resolution = _resolution.split('x');
    double aspectRatio =
        (int.parse(resolution.first) / int.parse(resolution.last));

    return aspectRatio;
  }

  String get refreshRate => _refreshRate;

  final List<String> availableRefreshRates;

  final List<String> availableResolutions;

  final List<double> availableScales;

  @override
  List<Object?> get props => <Object?>[
        _config,
        _fullResolution,
        _resolution,
        _scale,
        _primary,
        _transform,
        _refreshRate,
        _name,
      ];

  DisplayMonitorConfiguration copyWith({
    String? resolution,
    String? refreshRate,
    double? scale,
    int? transform,
    bool? primary,
    String? fullResolution,
  }) {
    return DisplayMonitorConfiguration._(
      _config,
      _index,
      fullResolution: fullResolution ?? _fullResolution,
      resolution: resolution ?? _resolution,
      scale: scale ?? _scale,
      primary: primary ?? _primary,
      transform: transform ?? _transform,
      refreshRate: refreshRate ?? _refreshRate,
      name: _name,
    );
  }
}
