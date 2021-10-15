import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/printers/printers_model.dart';
import 'package:settings/view/widgets/extra_options_gsettings_row.dart';
import 'package:settings/view/widgets/settings_row.dart';
import 'package:settings/view/widgets/settings_section.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

class PrintersPage extends StatelessWidget {
  const PrintersPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    // final service = Provider.of<SettingsService>(context, listen: false);
    return ChangeNotifierProvider<PrintersModel>(
      create: (_) => PrintersModel(),
      child: const PrintersPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 35, top: 15),
          child: SizedBox(
            width: 518,
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () => {},
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(YaruIcons.printer),
                          Padding(
                            padding: EdgeInsets.only(left: 12.0, right: 2),
                            child: Text('Add a printer'),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
        for (var i = 0; i < 10; i++)
          SettingsSection(headline: 'Printer ${i + 1}', children: [
            SettingsRow(
                trailingWidget: Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: Image.asset('assets/images/icons/printer.png',
                          fit: BoxFit.fill),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Model XYZ'),
                        SizedBox(
                          height: 8,
                        ),
                        Text('Ready')
                      ],
                    )
                  ],
                ),
                actionWidget: Row(
                  children: [
                    SizedBox(
                      height: 40,
                      child: OutlinedButton(
                          onPressed: () => {}, child: const Text('Open Queue')),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    OptionsButton(
                      onPressed: () => {},
                    ),
                  ],
                ))
          ])
      ],
    );
  }
}
