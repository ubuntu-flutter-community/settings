import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/view/pages/keyboard/input_source_model.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class InputSourceSelectionSection extends StatelessWidget {
  const InputSourceSelectionSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<InputSourceModel>();

    return FutureBuilder<List<String>?>(
      future: model.getInputSources(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return YaruSection(
            width: kDefaultWidth,
            headline: 'Input Sources',
            headerWidget: SizedBox(
              height: 40,
              width: 40,
              child: TextButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) => ChangeNotifierProvider.value(
                            value: model,
                            child: const _AddKeymapDialog(),
                          )),
                  child: const Icon(YaruIcons.plus)),
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
                onReorder: (int oldIndex, int newIndex) async {
                  final sources = snapshot.data!;
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final item = snapshot.data!.removeAt(oldIndex);
                  sources.insert(newIndex, item);
                  model.setInputSources(sources);
                },
              ),
            ]);
      },
    );
  }
}

class _InputTypeRow extends StatelessWidget {
  const _InputTypeRow({
    Key? key,
    required this.inputType,
  }) : super(key: key);

  final String inputType;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<InputSourceModel>();
    return YaruRow(
        enabled: true,
        actionWidget: Row(
          children: [
            YaruOptionButton(
                onPressed: () => model.showKeyboardLayout(inputType),
                iconData: YaruIcons.input_keyboard),
            const SizedBox(
              width: 10,
            ),
            YaruOptionButton(
                onPressed: () => model.removeInputSource(inputType),
                iconData: YaruIcons.trash)
          ],
        ),
        trailingWidget: Text(
          inputType,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
        leadingWidget: Icon(
          YaruIcons.drag_handle,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        ));
  }
}

class _AddKeymapDialog extends StatefulWidget {
  const _AddKeymapDialog({Key? key}) : super(key: key);

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
        ? YaruSimpleDialog(
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
                    child: YaruRow(
                      enabled: true,
                      width: 100,
                      description: model.inputSources[i].name,
                      actionWidget: const SizedBox(),
                      trailingWidget: Text(model.inputSources[i].description!),
                    ),
                  ),
              ])
        : YaruSimpleDialog(
            width: kDefaultWidth / 2,
            title: (model.inputSources[tabbedIndex].name ?? '') +
                ': ' +
                (model.inputSources[tabbedIndex].description ?? ''),
            closeIconData: YaruIcons.window_close,
            children: [
                for (var variant in model.inputSources[tabbedIndex].variants)
                  InkWell(
                    onTap: () {
                      if (model.inputSources[tabbedIndex].name != null &&
                          variant.name != null) {
                        model.addInputSource(
                            model.inputSources[tabbedIndex].name! +
                                '+' +
                                variant.name!);
                      }

                      Navigator.of(context).pop();
                      setState(() {});
                    },
                    borderRadius: BorderRadius.circular(4.0),
                    child: YaruRow(
                        enabled: true,
                        width: 100,
                        trailingWidget: Text(variant.description ?? ''),
                        description: variant.name ?? '',
                        actionWidget: const SizedBox()),
                  ),
                TextButton(
                    onPressed: () => setState(() {
                          variantsLoad = false;
                        }),
                    child: const Icon(YaruIcons.pan_start))
              ]);
  }
}
