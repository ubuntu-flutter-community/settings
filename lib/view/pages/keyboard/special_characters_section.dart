import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/keyboard/input_source_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SpecialCharactersSection extends StatelessWidget {
  const SpecialCharactersSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<InputSourceModel>();
    return FutureBuilder<List<String>?>(
      future: model.getXkbOptions(),
      builder: (context, snapshot) => !snapshot.hasData
          ? const CircularProgressIndicator()
          : YaruSection(headline: 'Special characters', children: [
              for (var item in snapshot.data!)
                YaruRow(
                    trailingWidget: Text(item.split(':').first),
                    actionWidget: Text(item.split(':').last))
            ]),
    );
  }
}
