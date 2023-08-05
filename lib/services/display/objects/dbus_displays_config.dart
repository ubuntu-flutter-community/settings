class DBusDisplaysConfig {
  DBusDisplaysConfig(List<dynamic> list)
      : serial = list[0],
        _monitors = list[1],
        _logicalMonitors = list[2];

  //_properties = list[3];

  /// @serial: configuration serial
  final int serial;

  /// @monitors: available monitors
  final List<dynamic> _monitors;

  /// @logical_monitors: current logical monitor configuration
  final List<dynamic> _logicalMonitors;

  /// @properties: display configuration properties
  //final Map<dynamic, dynamic> _properties;

  /// * s connector: connector name (e.g. HDMI-1, DP-1, etc)
  /// * s vendor: vendor name
  /// * s product: product name
  /// * s serial: product serial
  Identity identity(index) => Identity(_monitors[index][0]);

  /// * a(siiddada{sv}) modes: available modes
  List<Option> availableOptions(index) =>
      (_monitors[index][1] as List<dynamic>).map((e) => Option(e)).toList();

  Option? currentOption(index) {
    final List<Option> options = availableOptions(index);
    bool predicate(Option option) => option.isCurrent;
    if (options.any(predicate)) {
      return options.where(predicate).first;
    }
    return null;
  }

  ///@logical_monitors represent current logical monitor configuration
  ///     * i x: x position
  ///     * i y: y position
  ///     * d scale: scale
  ///     * u transform: transform (see below)
  ///     * b primary: true if this is the primary logical monitor
  ///     * a(sss) monitors: monitors displaying this logical monitor
  ///     * connector: name of the connector (e.g. DP-1, eDP-1 etc)
  ///     * vendor: vendor name
  ///     * product: product name
  ///     * serial: product serial
  ///     * a{sv} properties: possibly other properties
  ///     @layout_mode current layout mode represents the way logical monitors
  ///     are layed out on the screen. Possible modes include:
  ///     1 : physical
  ///     2 : logical
  ///     With physical layout mode, each logical monitor has the same dimensions
  ///     an the monitor modes of the associated monitors assigned to it, no
  ///     matter what scale is in use.
  ///     With logical mode, the dimension of a logical monitor is the dimension
  ///     of the monitor mode, divided by the logical monitor scale.
  ///     Possible @properties are:
  ///     * "supports-mirroring" (b): FALSE if mirroring not supported; TRUE or not
  ///     present if mirroring is supported.
  ///     * "layout-mode" (u): Represents in what way logical monitors are laid
  ///     out on the screen. The layout mode can be either
  ///     of the ones listed below. Absence of this property
  ///     means the layout mode cannot be changed, and that
  ///     "logical" mode is assumed to be used.
  ///     * 1 : logical  - the dimension of a logical monitor is derived from
  ///     the monitor modes associated with it, then scaled
  ///     using the logical monitor scale.
  ///     * 2 : physical - the dimension of a logical monitor is derived from
  ///     the monitor modes associated with it.
  ///     * "supports-changing-layout-mode" (b): True if the layout mode can be
  ///     changed. Absence of this means the
  ///     layout mode cannot be changed.
  ///     * "global-scale-required" (b): True if all the logical monitors must
  ///     always use the same scale. Absence of
  ///     this means logical monitor scales can
  ///     differ.
  ///
  LogicalConfiguration currentLogicalConfiguration(index) =>
      LogicalConfiguration(_logicalMonitors[index]);

  /// * a{sv} properties: optional properties, including:
  ///     - "width-mm" (i): physical width of monitor in millimeters
  ///     - "height-mm" (i): physical height of monitor in millimeters
  ///     - "is-underscanning" (b): whether underscanning is enabled
  ///     (absence of this means underscanning
  ///     not being supported)
  ///     - "max-screen-size" (ii): the maximum size a screen may have
  ///     (absence of this means unlimited screen
  ///     size)
  ///     - "is-builtin" (b): whether the monitor is built in, e.g. a
  ///     laptop panel (absence of this means it is
  ///     not built in)
  ///     - "display-name" (s): a human readable display name of the monitor
  ///     Possible mode flags:
  ///     1 : preferred mode
  ///     2 : current mode
  String displayName(index) => _monitors[index][2]['display-name'] ?? '';

  bool isBuiltin(index) => _monitors[index][2]['is-builtin'] ?? false;

  int get monitorsLength => _monitors.length;
}

class Identity {
  Identity(List<dynamic> monitors)
      : connector = monitors[0],
        vendor = monitors[1],
        product = monitors[2],
        serial = monitors[3];

  final String connector;
  final String vendor;
  final String product;
  final String serial;
}

/// * a(siiddada{sv}) modes: available modes
/// * s id: mode ID
/// * i width: width in physical pixels
/// * i height: height in physical pixels
/// * d refresh rate: refresh rate
/// * d preferred scale: scale preferred as per calculations
/// * ad supported scales: scales supported by this mode
/// * a{sv} properties: optional properties, including:
///     - "is-current" (b): the mode is currently active mode
///     - "is-preferred" (b): the mode is the preferred mode
/// * a{sv} properties: optional properties, including:
///     - "width-mm" (i): physical width of monitor in millimeters
///     - "height-mm" (i): physical height of monitor in millimeters
///     - "is-underscanning" (b): whether underscanning is enabled
class Option {
  Option(List<dynamic> monitor)
      : modeId = monitor[0],
        x = monitor[1],
        y = monitor[2],
        refreshRate = monitor[3],
        scale = monitor[4],
        availableScales = (monitor[5] as List<dynamic>)
            .map((e) => double.parse(e.toString()))
            .toList(),
        isCurrent = monitor[6]['is-current'] == true,
        isPreferred = monitor[6]['is-preferred'] == true;

  final String modeId;
  final int x;
  final int y;
  final double refreshRate;
  final double scale;
  final List<double> availableScales;
  final bool isCurrent;
  final bool isPreferred;
}

class LogicalConfiguration {
  LogicalConfiguration(List<dynamic> logicalMonitor)
      : offsetX = logicalMonitor[0],
        offsetY = logicalMonitor[1],
        scale = logicalMonitor[2],
        orientation = logicalMonitor[3],
        primary = logicalMonitor[4];

  final int offsetX;
  final int offsetY;
  final double scale;
  final int orientation;
  final bool primary;
}
