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

    return FutureBuilder<List<String>?>(
      future: model.sources,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return YaruSection(headline: 'Input Sources', children: [
          ReorderableListView(
            shrinkWrap: true,
            children: <Widget>[
              for (int index = 0; index < snapshot.data!.length; index++)
                ListTile(
                  key: Key('$index'),
                  title: Text('${index + 1}. ${snapshot.data![index]}'),
                ),
            ],
            onReorder: (int oldIndex, int newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final item = snapshot.data!.removeAt(oldIndex);
              snapshot.data!.insert(newIndex, item);
            },
          )
        ]);
      },
    );

    // return YaruSection(headline: 'Input Sources', children: [
    //   ReorderableListView(
    //     shrinkWrap: true,
    //     children: <Widget>[
    //       for (int index = 0; index < model.sources.length; index++)
    //         ListTile(
    //           key: Key('$index'),
    //           title: Text('${index + 1}. ${model.sources[index]}'),
    //         ),
    //     ],
    //     onReorder: (int oldIndex, int newIndex) {
    //       if (oldIndex < newIndex) {
    //         newIndex -= 1;
    //       }
    //       final item = model.sources.removeAt(oldIndex);
    //       model.sources.insert(newIndex, item);
    //     },
    //   )
    // ]);
  }
}
