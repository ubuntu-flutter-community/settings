import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';
import 'package:provider/src/provider.dart';
import 'package:settings/view/pages/chose_your_look_page.dart';
import 'package:settings/view/widgets/app_theme.dart';

class AppearancePage extends StatefulWidget {
  const AppearancePage({Key? key}) : super(key: key);

  @override
  State<AppearancePage> createState() => _AppearancePageState();
}

class _AppearancePageState extends State<AppearancePage> {
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

    final theme = context.watch<AppTheme>();
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChoseYourLookPage(theme: theme),
            ),
            SizedBox(
              width: 300,
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
              width: 300,
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
              width: 300,
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
              width: 300,
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
            )
          ],
        ),
      ),
    );
  }
}
