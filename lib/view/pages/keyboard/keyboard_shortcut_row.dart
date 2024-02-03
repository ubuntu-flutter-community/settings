import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/keyboard/keyboard_shortcuts_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class KeyboardShortcutRow extends StatefulWidget {
  const KeyboardShortcutRow({
    super.key,
    required this.label,
    required this.shortcutId,
  });

  final String label;
  final String shortcutId;

  @override
  State<KeyboardShortcutRow> createState() => _KeyboardShortcutRowState();
}

class _KeyboardShortcutRowState extends State<KeyboardShortcutRow> {
  List<LogicalKeyboardKey> keys = [];

  @override
  Widget build(BuildContext context) {
    final model = context.watch<KeyboardShortcutsModel>();
    final shortcut = context.select<KeyboardShortcutsModel, List<String>>(
      (model) => model.getShortcutStrings(widget.shortcutId),
    );

    return InkWell(
      borderRadius: BorderRadius.circular(4.0),
      onTap: () async {
        final oldShortcut = model.getShortcutStrings(widget.shortcutId);
        await model.grabKeyboard().then((value) {
          if (!value) return;
          showDialog<List<String>>(
            context: context,
            builder: (_) => StatefulBuilder(
              builder: (context, setState) {
                return RawKeyboardListener(
                  focusNode: FocusNode(),
                  autofocus: true,
                  onKey: (event) {
                    if (event.logicalKey != LogicalKeyboardKey.escape &&
                        !keys.contains(event.logicalKey) &&
                        keys.length < 4) {
                      setState(() => keys.add(event.logicalKey));
                    }
                  },
                  child: KeyboardShortcutDialog(
                    keys: keys,
                    oldShortcut: oldShortcut,
                  ),
                );
              },
            ),
          ).then((shortcut) {
            keys.clear();
            model.setShortcut(widget.shortcutId, shortcut ?? oldShortcut);
            model.ungrabKeyboard();
          });
        });
      },
      child: YaruTile(
        title: Text(widget.label),
        trailing: Row(
          children: [
            for (final string in shortcut)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    string,
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class KeyboardShortcutDialog extends StatelessWidget {
  const KeyboardShortcutDialog({
    super.key,
    required this.keys,
    required this.oldShortcut,
  });

  final List<LogicalKeyboardKey> keys;
  final List<String> oldShortcut;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Start typing... ',
        style: Theme.of(context).textTheme.titleMedium,
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
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(oldShortcut);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          child: const Text('Confirm'),
          onPressed: () => Navigator.of(context).pop([processKeys(keys)]),
        ),
      ],
    );
  }

  String processKeys(List<LogicalKeyboardKey> keys) {
    final keyBuffer = StringBuffer();
    for (final key in keys) {
      var keyLabel = key.keyLabel;
      if (keyLabel == 'Alt Left' ||
          keyLabel == 'Control Left' ||
          keyLabel == 'Meta Left' ||
          keyLabel == 'Super Left' ||
          keyLabel == 'Shift Left') {
        keyLabel = '<${keyLabel.replaceAll(' Left', '')}>';
      } else if (keyLabel == 'Alt Right' ||
          keyLabel == 'Control Right' ||
          keyLabel == 'Meta Right' ||
          keyLabel == 'Super Right' ||
          keyLabel == 'Shift Right') {
        keyLabel = '<${keyLabel.replaceAll(' Right', '')}>';
      } else if (keyLabel == 'Meta' || keyLabel == 'Super') {
        keyLabel = '<$keyLabel>';
      }
      keyBuffer.write(keyLabel);
    }
    return keyBuffer.toString();
  }
}
