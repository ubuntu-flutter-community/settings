import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/removable_media/removable_media_model.dart';
import 'package:settings/view/widgets/checkbox_row.dart';
import 'package:settings/view/widgets/settings_section.dart';

class RemovableMediaPage extends StatelessWidget {
  const RemovableMediaPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<RemovableMediaModel>(
      create: (_) => RemovableMediaModel(),
      child: const RemovableMediaPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RemovableMediaModel>(context);

    return SettingsSection(headline: 'Removable Media', children: [
      CheckboxRow(
          enabled: true,
          value: model.autoRunNever,
          onChanged: (value) => model.autoRunNever = value!,
          text: 'Never ask')
    ]);
  }
}
