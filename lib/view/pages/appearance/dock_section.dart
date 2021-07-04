import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/settings_row.dart';

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
    String _dockPosition = _settings.stringValue('dock-position');

    final List<bool> _dockPositions = [
      _dockPosition.contains('LEFT'),
      _dockPosition.contains('RIGHT'),
      _dockPosition.contains('BOTTOM')
    ];

    return SettingsSection(headline: 'Dock Settings', children: [
      BoolSettingsRow(
          actionLabel: 'Show trash',
          settingsKey: 'show-trash',
          settings: _settings),
      BoolSettingsRow(
          actionLabel: 'Always show the dock',
          settingsKey: 'dock-fixed',
          settings: _settings),
      BoolSettingsRow(
          actionLabel: 'Extend the height of the dock',
          settingsKey: 'extend-height',
          settings: _settings),
      BoolSettingsRow(
          actionLabel: 'Active app glow',
          settingsKey: 'unity-backlit-items',
          settings: _settings),
      DiscreteSlider(
          actionLabel: 'Max icon size',
          settingsKey: 'dash-max-icon-size',
          settings: _settings),
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
    ]);
  }
}
