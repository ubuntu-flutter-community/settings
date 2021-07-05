import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsettings/gsettings.dart';
import 'package:settings/view/widgets/settings_row.dart';

class KeyboardShortcutRow extends StatefulWidget {
  final String schemaId;
  final String settingsKey;

  const KeyboardShortcutRow(
      {Key? key, required this.schemaId, required this.settingsKey})
      : super(key: key);

  @override
  _KeyboardShortcutRowState createState() => _KeyboardShortcutRowState();
}

class _KeyboardShortcutRowState extends State<KeyboardShortcutRow> {
  List<LogicalKeyboardKey> keys = [];
  late GSettings _settings;

  @override
  void initState() {
    _settings = GSettings(schemaId: widget.schemaId);

    super.initState();
  }

  @override
  void dispose() {
    _settings.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _switchWindows = _settings.stringArrayValue(widget.settingsKey);

    return InkWell(
      child: SettingsRow(
          actionLabel: 'Switch windows',
          secondChild: Text(
            _switchWindows.toString(),
            style: TextStyle(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.4)),
          )),
      borderRadius: BorderRadius.circular(4.0),
      onTap: () => showDialog(
          context: context,
          builder: (_) => StatefulBuilder(builder: (context, setState) {
                return RawKeyboardListener(
                  focusNode: FocusNode(),
                  autofocus: true,
                  onKey: (event) {
                    if (event.logicalKey == LogicalKeyboardKey.escape) {
                      keys.clear();
                      return;
                    }
                    if (!keys.contains(event.logicalKey) && keys.length < 4) {
                      setState(() => keys.add(event.logicalKey));
                    }
                  },
                  child: AlertDialog(
                    title: Text(
                      "Start typing... ",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    content: SizedBox(
                      height: 100,
                      width: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: keys
                                .map((key) => Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(key.keyLabel),
                                      ),
                                    ))
                                .toList(),
                          ),
                          Text(
                            keys.isEmpty ? '' : 'Press ESC or cancel to cancel',
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      OutlinedButton(
                          onPressed: () {
                            keys.clear();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel')),
                      ElevatedButton(
                        child: const Text('Confirm'),
                        onPressed: () {
                          // TODO: How to prevent gnome shell
                          // from executing key combos while typing?
                          // TODO: get the real VALUE here to set
                          // setState(() => _settings
                          //     .setValue('switch-windows', ["<Alt>Tab"]));
                          keys.clear();
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                );
              })),
    );
  }
}
