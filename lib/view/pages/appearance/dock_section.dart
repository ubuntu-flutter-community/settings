import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';

class DockSection extends StatefulWidget {
  const DockSection({Key? key}) : super(key: key);

  @override
  State<DockSection> createState() => _DockSectionState();
}

class _DockSectionState extends State<DockSection> {
  late GSettings _settings;

  @override
  void initState() {
    _settings = GSettings(schemaId: 'org.gnome.shell.extensions.dash-to-dock');
    super.initState();
  }

  @override
  void dispose() {
    _settings.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _showTrash = _settings.boolValue('show-trash');
    bool _alwaysShowDock = _settings.boolValue('dock-fixed');
    bool _extendHeight = _settings.boolValue('extend-height');
    bool _unityBacklidItems = _settings.boolValue('unity-backlit-items');
    int _dashMaxIconSize = _settings.intValue('dash-max-icon-size');
    String _dockPosition = _settings.stringValue('dock-position');

    final List<bool> _dockPositions = [
      _dockPosition.contains('LEFT'),
      _dockPosition.contains('RIGHT'),
      _dockPosition.contains('BOTTOM')
    ];

    return Column(
      children: [
        SizedBox(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Dock settings',
                style: Theme.of(context).textTheme.headline6,
              ),
            )),
        Column(
          children: [
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Show trash on dock'),
                    Switch(
                      value: _showTrash,
                      onChanged: (bool newValue) {
                        _settings.setValue('show-trash', newValue);

                        setState(() {
                          _showTrash = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Always show the dock'),
                    Switch(
                      value: _alwaysShowDock,
                      onChanged: (bool newValue) {
                        _settings.setValue('dock-fixed', newValue);
                        setState(() {
                          _alwaysShowDock = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Extend the height of the dock'),
                    Switch(
                      value: _extendHeight,
                      onChanged: (bool newValue) {
                        _settings.setValue('extend-height', newValue);
                        setState(() {
                          _extendHeight = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Active apps glow'),
                    Switch(
                      value: _unityBacklidItems,
                      onChanged: (bool newValue) {
                        _settings.setValue('unity-backlit-items', newValue);
                        setState(() {
                          _unityBacklidItems = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Icon size'),
                    Expanded(
                      child: Slider(
                        label: '$_dashMaxIconSize',
                        min: 16,
                        max: 64,
                        value: _dashMaxIconSize + .0,
                        divisions: 24,
                        onChanged: (double newValue) {
                          _settings.setValue(
                              'dash-max-icon-size', newValue.round());
                          setState(() {
                            _dashMaxIconSize = newValue.round();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Dock position'),
                    ButtonTheme(
                      minWidth: double.infinity,
                      child: ToggleButtons(
                        children: const <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 14, right: 14),
                            child: Text('Left'),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 14, right: 14),
                            child: Text('Right'),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 14, right: 14),
                            child: Text('Bottom'),
                          ),
                        ],
                        onPressed: (int index) {
                          setState(() {
                            for (int buttonIndex = 0;
                                buttonIndex < _dockPositions.length;
                                buttonIndex++) {
                              if (buttonIndex == index) {
                                _dockPositions[buttonIndex] = true;
                              } else {
                                _dockPositions[buttonIndex] = false;
                              }
                            }
                            if (_dockPositions[0] == true) {
                              _settings.setValue('dock-position', 'LEFT');
                            } else if (_dockPositions[1] == true) {
                              _settings.setValue('dock-position', 'RIGHT');
                            } else if (_dockPositions[2] == true) {
                              _settings.setValue('dock-position', 'BOTTOM');
                            }
                          });
                        },
                        isSelected: _dockPositions,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
