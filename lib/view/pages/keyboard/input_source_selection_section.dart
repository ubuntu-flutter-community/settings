import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/common/settings_section.dart';
import 'package:settings/view/pages/keyboard/input_source_model.dart';
import 'package:settings/view/pages/settings_simple_dialog.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class InputSourceSelectionSection extends StatelessWidget {
  const InputSourceSelectionSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<InputSourceModel>();

    return FutureBuilder<List<String>?>(
      future: model.getInputSources(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const YaruCircularProgressIndicator();
        }
        return SettingsSection(
          width: kDefaultWidth,
          headline: const Text('Input Sources'),
          headerWidget: SizedBox(
            height: 40,
            width: 40,
            child: TextButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => ChangeNotifierProvider.value(
                  value: model,
                  child: const _AddKeymapDialog(),
                ),
              ),
              child: const Icon(YaruIcons.plus),
            ),
          ),
          children: [
            ReorderableListView(
              buildDefaultDragHandles: false,
              shrinkWrap: true,
              children: <Widget>[
                for (int index = 0; index < snapshot.data!.length; index++)
                  ReorderableDragStartListener(
                    key: Key('$index'),
                    index: index,
                    child: ChangeNotifierProvider.value(
                      value: model,
                      child: _InputTypeRow(
                        inputType: snapshot.data![index],
                      ),
                    ),
                  ),
              ],
              onReorder: (oldIndex, newIndex) async {
                final sources = snapshot.data!;
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final item = snapshot.data!.removeAt(oldIndex);
                sources.insert(newIndex, item);
                await model.setInputSources(sources);
              },
            ),
          ],
        );
      },
    );
  }
}

class _InputTypeRow extends StatelessWidget {
  const _InputTypeRow({
    required this.inputType,
  });

  final String inputType;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<InputSourceModel>();
    return YaruTile(
      trailing: Row(
        children: [
          YaruOptionButton(
            onPressed: () => model.showKeyboardLayout(inputType),
            child: const Icon(YaruIcons.keyboard),
          ),
          const SizedBox(
            width: 10,
          ),
          YaruOptionButton(
            onPressed: () => model.removeInputSource(inputType),
            child: const Icon(YaruIcons.trash),
          ),
        ],
      ),
      title: Text(
        inputType,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      ),
      leading: Icon(
        YaruIcons.drag_handle,
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      ),
    );
  }
}

class _AddKeymapDialog extends StatefulWidget {
  const _AddKeymapDialog();

  @override
  State<_AddKeymapDialog> createState() => _AddKeymapDialogState();
}

class _AddKeymapDialogState extends State<_AddKeymapDialog> {
  int tabbedIndex = 0;
  bool variantsLoad = false;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<InputSourceModel>();
    return variantsLoad == false
        ? SettingsSimpleDialog(
            width: kDefaultWidth / 2,
            title: 'Add Keymap',
            closeIconData: YaruIcons.window_close,
            children: [
              for (var i = 0; i < model.inputSources.length; i++)
                InkWell(
                  borderRadius: BorderRadius.circular(4.0),
                  onTap: () => setState(() {
                    tabbedIndex = i;
                    variantsLoad = true;
                  }),
                  child: SizedBox(
                    width: 100,
                    child: YaruTile(
                      subtitle: Text(model.inputSources[i].name ?? ''),
                      trailing: const SizedBox(),
                      title: Text(model.inputSources[i].description!),
                    ),
                  ),
                ),
            ],
          )
        : SettingsSimpleDialog(
            width: kDefaultWidth / 2,
            title:
                '${model.inputSources[tabbedIndex].name ?? ''}: ${model.inputSources[tabbedIndex].description ?? ''}',
            closeIconData: YaruIcons.window_close,
            children: [
              for (final variant in model.inputSources[tabbedIndex].variants)
                InkWell(
                  onTap: () {
                    if (model.inputSources[tabbedIndex].name != null &&
                        variant.name != null) {
                      model.addInputSource(
                        '${model.inputSources[tabbedIndex].name!}+${variant.name!}',
                      );
                    }

                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  borderRadius: BorderRadius.circular(4.0),
                  child: SizedBox(
                    width: 100,
                    child: YaruTile(
                      title: Text(variant.description ?? ''),
                      subtitle: Text(variant.name ?? ''),
                      trailing: const SizedBox(),
                    ),
                  ),
                ),
              TextButton(
                onPressed: () => setState(() {
                  variantsLoad = false;
                }),
                child: const Icon(YaruIcons.pan_start),
              ),
            ],
          );
  }
}
