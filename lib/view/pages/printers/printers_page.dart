import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/printers/printers_model.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class PrintersPage extends StatefulWidget {
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
  State<PrintersPage> createState() => _PrintersPageState();
}

class _PrintersPageState extends State<PrintersPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PrintersModel>();
    return YaruPage(
      children: [
        ChangeNotifierProvider.value(
          value: model,
          child: const _Header(),
        ),
        const SizedBox(
          height: 20,
        ),
        FutureBuilder<List<String>>(
            future: model.loadPrinters(),
            builder: (context, snapshot) => snapshot.hasData
                ? ListView(
                    shrinkWrap: true,
                    children: snapshot.data!
                        .map((e) => _PrinterSection(name: e))
                        .toList(),
                  )
                : const LinearProgressIndicator())
      ],
    );
  }
}

class _PrinterSection extends StatelessWidget {
  const _PrinterSection({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return YaruSection(width: kDefaultWidth, headline: name, children: [
      YaruRow(
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
            Expanded(
              child: SizedBox(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Flexible(
                        child: Text(
                      'Model XYZ',
                      overflow: TextOverflow.ellipsis,
                    )), // printer.type
                    SizedBox(
                      height: 3,
                    ),
                    Flexible(
                      child: Text('bla', overflow: TextOverflow.ellipsis),
                    ), // printer.location
                    // printer.status
                  ],
                ),
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
    ]);
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PrintersModel>();
    return SizedBox(
      width: kDefaultWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => StatefulBuilder(builder: (context, setState) {
                    return AddPrinterDialog(
                      children: [
                        Icon(
                          YaruIcons.printer,
                          color: Theme.of(context).colorScheme.primary,
                          size: 50,
                        )
                      ],
                      onConfirm: () {
                        Navigator.of(context).pop();
                        return ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                                content: Icon(
                          YaruIcons.printer,
                          color: Theme.of(context).colorScheme.primary,
                        )));
                      },
                      title: 'Add Printer',
                    );
                  }),
                );
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
          YaruOptionButton(
              onPressed: () => model.openPrinterSettings(),
              iconData: YaruIcons.settings)
        ],
      ),
    );
  }
}

class AddPrinterDialog extends StatelessWidget {
  const AddPrinterDialog({Key? key, this.onConfirm, this.title, this.children})
      : super(key: key);

  final Function()? onConfirm;
  final String? title;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: SimpleDialog(
        titlePadding: EdgeInsets.zero,
        title: YaruDialogTitle(
          mainAxisAlignment: MainAxisAlignment.center,
          closeIconData: YaruIcons.window_close,
          title: title,
        ),
        contentPadding: EdgeInsets.zero,
        children: [
          const Icon(
            YaruIcons.printer,
            size: 80,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: kDefaultWidth / 3,
              child: Row(children: [
                Expanded(
                  child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(context.l10n.cancel)),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: onConfirm,
                      child: Text(
                        context.l10n.confirm,
                      )),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
