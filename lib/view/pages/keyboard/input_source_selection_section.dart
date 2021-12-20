import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/keyboard/input_source_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class InputSourceSelectionSection extends StatelessWidget {
  const InputSourceSelectionSection({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<InputSourceModel>();
    final sources = model.sources?.toList() ?? [];
    return YaruSection(headline: 'Input Sources', children: [
      ReorderableListView(
        shrinkWrap: true,
        children: <Widget>[
          for (int index = 0; index < sources.length; index++)
            ListTile(
              key: Key('$index'),
              title: Text('${index + 1}. ${sources[index]}'),
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = sources.removeAt(oldIndex);
          sources.insert(newIndex, item);
          model.sources = sources.toList();
        },
      )
    ]);
  }
}
