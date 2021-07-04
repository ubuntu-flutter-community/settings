import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:settings/view/widgets/settings_row.dart';

class MouseSection extends StatefulWidget {
  const MouseSection({Key? key}) : super(key: key);

  @override
  State<MouseSection> createState() => _MouseSectionState();
}

class _MouseSectionState extends State<MouseSection> {
  late GSettings _settings;

  @override
  void initState() {
    _settings = GSettings(schemaId: 'org.gnome.desktop.peripherals.mouse');
    super.initState();
  }

  @override
  void dispose() {
    _settings.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _mouseSpeed = _settings.doubleValue('speed');

    return SettingsSection(headline: 'Mouse', children: [
      SizedBox(
        width: 500,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Speed'),
              Expanded(
                child: Slider(
                  label: '$_mouseSpeed',
                  value: _mouseSpeed,
                  onChanged: (double newValue) {
                    _settings.setValue('speed', newValue);
                    setState(() {
                      _mouseSpeed = newValue;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      BoolSettingsRow(
          actionLabel: 'Natural Scrolling',
          settingsKey: 'natural-scroll',
          settings: _settings)
    ]);
  }
}
