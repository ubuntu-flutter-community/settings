import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/keyboard_shortcuts/keyboard_shortcuts_model.dart';
import 'package:settings/view/widgets/settings_row.dart';

class KeyboardShortcutRow extends StatefulWidget {
  const KeyboardShortcutRow({
    Key? key,
    required this.label,
    required this.shortcutId,
  }) : super(key: key);

  final String label;
  final String shortcutId;

  @override
  _KeyboardShortcutRowState createState() => _KeyboardShortcutRowState();
}

class _KeyboardShortcutRowState extends State<KeyboardShortcutRow> {
  List<LogicalKeyboardKey> keys = [];

  @override
  Widget build(BuildContext context) {
    final model = context.read<KeyboardShortcutsModel>();
    final shortcut = context.select<KeyboardShortcutsModel, List<String>>(
        (model) => model.shortcut(widget.shortcutId));

    return InkWell(
      child: SettingsRow(
        actionLabel: widget.label,
        secondChild: Text(
          shortcut.toString(),
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4)),
        ),
      ),
      borderRadius: BorderRadius.circular(4.0),
      onTap: () {
        final oldShortcut = model.shortcut(widget.shortcutId);
        // TODO: grab the keyboard from gnome-shell
        showDialog<List<String>>(
          barrierDismissible: false,
          context: context,
          builder: (_) => StatefulBuilder(builder: (context, setState) {
            return RawKeyboardListener(
              focusNode: FocusNode(),
              autofocus: true,
              onKey: (event) {
                if (event.logicalKey == LogicalKeyboardKey.escape) {
                  Navigator.of(context).pop();
                }
                if (!keys.contains(event.logicalKey) && keys.length < 4) {
                  setState(() => keys.add(event.logicalKey));
                }
              },
              child: AlertDialog(
                title: Text(
                  'Start typing... ',
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
                            .map(
                              (key) => Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(key.keyLabel),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Text(
                        keys.isEmpty ? '' : 'Press cancel to cancel',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
                actions: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                  ElevatedButton(
                    child: const Text('Confirm'),
                    onPressed: () {
                      final keyBuffer = StringBuffer();
                      for (var key in keys) {
                        var keyLabel = key.keyLabel;
                        if (keyLabel == 'Alt Left' ||
                            keyLabel == 'Control Left' ||
                            keyLabel == 'Super Left' ||
                            keyLabel == 'Shift Left') {
                          keyLabel =
                              '<' + keyLabel.replaceAll(' Left', '') + '>';
                        } else if (keyLabel == 'Alt Right' ||
                            keyLabel == 'Control Right' ||
                            keyLabel == 'Super Right' ||
                            keyLabel == 'Shift Right') {
                          keyLabel =
                              '<' + keyLabel.replaceAll(' Right', '') + '>';
                        }
                        keyBuffer.write(keyLabel);
                      }
                      Navigator.of(context).pop([keyBuffer.toString()]);
                    },
                  )
                ],
              ),
            );
          }),
        ).then((shortcut) {
          keys.clear();
          model.setShortcut(widget.shortcutId, shortcut ?? oldShortcut);
        });
      },
    );
  }
}
