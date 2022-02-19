import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/printers/printers_model.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class PrintersPage extends StatelessWidget {
  const PrintersPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    // final service = Provider.of<SettingsService>(context, listen: false);
    return ChangeNotifierProvider<PrintersModel>(
      create: (_) => PrintersModel(),
      child: const PrintersPage(),
    );
  }

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.printersPageTitle);

  static bool searchMatches(String value, BuildContext context) =>
      value.isNotEmpty
          ? context.l10n.printersPageTitle
              .toLowerCase()
              .contains(value.toLowerCase())
          : false;

  @override
  Widget build(BuildContext context) {
    return YaruPage(
      children: [
        SizedBox(
          width: kDefaultWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) =>
                          StatefulBuilder(builder: (context, setState) {
                        return const AddPrinterDialog();
                      }),
                    ).then((shortcut) {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(YaruIcons.plus),
                      Padding(
                        padding: EdgeInsets.only(left: 12.0, right: 2),
                        child: Text('Add a printer'),
                      )
                    ],
                  )),
              const SizedBox(
                width: 12,
              ),
              OutlinedButton(
                  onPressed: () {},
                  child: const Text('Additional printer settings ...'))
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        for (var i = 0; i < 10; i++)
          YaruSection(
              width: kDefaultWidth,
              headline: 'Printer ${i + 1}',
              children: [
                YaruRow(
                  trailingWidget: Row(
                    children: [
                      SizedBox(
                        width: 70,
                        child: Image.asset(
                            i.isEven
                                ? 'assets/images/icons/printer.png'
                                : 'assets/images/icons/printer-network.png',
                            fit: BoxFit.fill),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Model XYZ'), // printer.type
                            const SizedBox(
                              height: 3,
                            ),
                            Text(i.isEven
                                ? 'local'
                                : '192.168.1.1337'), // printer.location
                            // printer.status
                          ],
                        ),
                      )
                    ],
                  ),
                  actionWidget: Row(
                    children: [
                      const SizedBox(
                        height: 40,
                        child: OutlinedButton(
                            onPressed: null, // printer.activejobs ?
                            child: Text(
                              'No active jobs',
                              // style: TextStyle(
                              //     color: Theme.of(context).disabledColor),
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      YaruOptionButton(
                        iconData: YaruIcons.settings,
                        onPressed: () => {},
                      ),
                    ],
                  ),
                  enabled: true,
                )
              ])
      ],
    );
  }
}

class AddPrinterDialog extends StatelessWidget {
  const AddPrinterDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a printer'),
      content: SizedBox(
        height: 300,
        width: 380,
        child: Column(
          children: const [],
        ),
      ),
      actions: [
        OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel')),
        ElevatedButton(onPressed: () {}, child: const Text('Add printer'))
      ],
    );
  }
}
