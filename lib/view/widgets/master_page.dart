import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/view/widgets/detail_page.dart';
import 'package:settings/view/widgets/detail_route.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({Key? key}) : super(key: key);

  @override
  MasterPageState createState() => MasterPageState();
}

class MasterPageState extends State<MasterPage> {
  final items = List<String>.generate(20, (i) => "Item $i");
  String selectedItem = "Item 0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text('Master'),
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                    selected: items[index] == selectedItem,
                    title: Text(items[index]),
                    onTap: () {
                      setState(() {
                        selectedItem = items[index];

                        // To remove the previously selected detail page
                        while (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }

                        Navigator.of(context)
                            .push(DetailRoute(builder: (context) {
                          return DetailPage(item: selectedItem);
                        }));
                      });
                    });
              }),
        ));
  }
}
